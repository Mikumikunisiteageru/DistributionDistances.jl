# test/runtests.jl

using Aqua
using DistributionDistances
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
	@test isapprox(0.65, wasserstein([1,1,2,3], [0.8,2.5,3.5]))
end
