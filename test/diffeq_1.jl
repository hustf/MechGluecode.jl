using Test
using MechGluecode
using MechanicalUnits
using MechanicalUnits: Unitfu.promote_to_derived
@import_expand(m, s, N) # Takes long if defined late)
using DifferentialEquations


@testset "Unitful time with unitless state" begin
    u0 = 30.0s
    tspan = (0.0, 10.0)s
    prob1 = ODEProblem((du,u,t,p) -> (du[1] = -0.2∙s⁻¹ * u[1]), [u0], tspan)
    prob2 = ODEProblem((u,t,p)    -> (-0.2∙s⁻¹ * u[1]), u0, tspan)
    prob3 = ODEProblem((u,t,p)    -> [-0.2∙s⁻¹* u[1]], [u0],tspan)
    for prob in [prob1, prob2, prob3]
        @test solve(prob, Tsit5()).retcode === :Success
    end
end
@testset "ODE quantity" begin
    f = (y, p, t) -> 0.5y / 3.0s  # The derivative, yeah
    u0 = 1.5N
    tspan = (0.0s, 1.0s)
    prob = ODEProblem(f, u0, tspan)
    sol = solve(prob)
    @test sol.t isa Vector{<:Time}
    @test sol.u isa Vector{<:Force}
end

