# test/runtests.jl

using Aqua
using DistributionDistances
using Distributions
using Test

Aqua.test_ambiguities(DistributionDistances)
Aqua.test_unbound_args(DistributionDistances)
Aqua.test_undefined_exports(DistributionDistances)
Aqua.test_piracies(DistributionDistances)
Aqua.test_project_extras(DistributionDistances)
Aqua.test_stale_deps(DistributionDistances)
Aqua.test_deps_compat(DistributionDistances)
Aqua.test_deps_compat(DistributionDistances)

@testset "wasserstein" begin
	@test_throws DomainError wasserstein([1], [2]; p=0.5)
	@test_throws TypeError wasserstein([1], [2]; p=Int)
	@test isapprox(0.65, wasserstein([1,1,2,3], [0.8,2.5,3.5]))
	@test isapprox(0.65, wasserstein([1,1,2,3,1,1,2,3], [0.8,2.5,3.5]))
	@test isapprox(0.65, wasserstein([1,1,2,3,1,1,2,3], [0.8,2.5,3.5,0.8,2.5,3.5]))
	@test isapprox(sqrt(0.68), wasserstein([1,1,2,3], [0.8,2.5,3.5]; p=2))
	@test isapprox(cbrt(0.8985), wasserstein([1,1,2,3], [0.8,2.5,3.5]; p=3))
	@test isapprox(1.0, wasserstein(Uniform(0,1), Uniform(1,2)))
	@test isapprox(1.0, wasserstein(Normal(0,1), Normal(1,1)))
	@test isapprox(0.29788455f0, wasserstein(Normal(0,1), Uniform(-1,1)))
	@test isapprox(1.0, wasserstein(Uniform(0,1), Uniform(1,2); p=2))
	@test isapprox(1.0, wasserstein(Normal(0,1), Normal(1,1); p=2))
	@test isapprox(0.45271865f0, wasserstein(Normal(0,1), Uniform(-1,1); p=2))
end
