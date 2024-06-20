# src/DistributionDistances.jl

module DistributionDistances

export wasserstein

function mergesorted(v1, v2)
	n1, n2 = length(v1), length(v2)
	T = promote_type(eltype(v1), eltype(v2))
	v = Vector{T}(undef, n1 + n2)
	i1 = i2 = i = 1
	while true
		if v1[i1] < v2[i2]
			v[i] = v1[i1]
			i1 += 1
			if i1 > n1
				v[i+1:n1+n2] .= v2[i2:n2]
				break
			end
		else
			v[i] = v2[i2]
			i2 += 1
			if i2 > n2
				v[i+1:n1+n2] .= v1[i1:n1]
				break
			end
		end
		i += 1
	end
	return v
end

function wasserstein(x1::AbstractVector{<:Real}, x2::AbstractVector{<:Real}; p::Real=1)
	p < 1 && raise(DomainError(p), "`p >= 1` must hold in Wasserstein distance")
	n1, n2 = length(x1), length(x2)
	x1, x2 = sort(x1), sort(x2)
	v1 = [(i//n1, x1[min(n1, i+1)], 1) for i = 1:n1]
	v2 = [(i//n2, x2[min(n2, i+1)], 2) for i = 1:n2]
	v = mergesorted(v1, v2)
	s = zero(float(promote_type(eltype(x1), eltype(x2))))
	q0 = 0//1
	f1, f2 = x1[1], x2[1]
	for (q, f, j) = v
		s += (q - q0) * abs(f1 - f2) ^ p
		q0 = q
		j == 1 ? f1 = f : f2 = f
	end
	return s ^ (1//p)
end

end # module DistributionDistances
