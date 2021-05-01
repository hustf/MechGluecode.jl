using Test
using MechGluecode
using MechanicalUnits
using MechanicalUnits: Unitfu.promote_to_derived
@import_expand(~m, s, N)
using DifferentialEquations
import MechGluecode: norm # should work without

@testset "Initial checks ArrayPartition" begin
    r0 = [1131.340, -2282.343, 6672.423]∙km
    v0 = [-5.64305, 4.30333, 2.42879]∙km/s
    Δt = 86400.0*365∙s
    μ = 398600.4418∙km³/s²
    rv0 = ArrayPartition(r0,v0)

    function fo(dy, y, μ, t)
        r = norm(y.x[1])
        dy.x[1] .= y.x[2]
        dy.x[2] .= -μ .* y.x[1] / r^3
    end
    prob = ODEProblem(fo, rv0, (0.0s, 0.035Δt), μ)
    @time sol = solve(prob, Tsit5(), dt = 0.1s);
    # Plot all variables vs time
    plot(sol)
    plot(sol, vars = (1))
    plot(sol, vars = (2))
    plot(sol, vars = (3))
    plot(sol, vars = (4))
    plot(sol, vars = (5))
    plot(sol, vars = (6))

    # Plot in phase space
    plot(sol, vars=(1,4))
    plot(sol, vars=(2,5))
    plot(sol, vars=(3,6))
    plot(sol, vars=(2,5))
    # Three distances vs time (0)
    plot(sol, vars=[(0,1), (0,2),(0,3)])
    # Three velocities vs time (0)
    plot(sol, vars=[(0,4), (0,5),(0,6)])
end
#=
@testset "Plot ODE system single pendulum" begin
    # Second order non-linear, undamped pendulum:
    # mLθ'' + mg∙sin(θ)
    # where m is mass, unit kg
    #       L is length, unit m
    #       θ is angle to vertical, strictly no unit
    #       g is gravity's acceleration
    # Acceleration
    # θ'' + k * sin(θ) = 0
    #    where k = g / L , unit(k) = s⁻²
    # Reduced to first order non-linear system by defining:
    # θ = y[1]
    # θ' = y[2]
    # It follows that
    # θ'' = y'[2]
    # and
    # y'[1] = y[2]
    # y'[2] = -k * sin(y[1])
    # To solve numerically, we define the derivative.
    # For efficiency, it's evaluated in place, i.e. dy changes at every call.
    function f!(dy, y, k, t)
        dy[1] = y[2]
        dy[2] = -k ∙ sin(y[1])
    end
    # Fixed parameter
    k = upreferred(g / 1.0m)
    # Initial conditions
    θ0 = 0.1
    θ0_vel = 0.0s⁻¹
    θ0_acc = -k *sin(θ0)

    y0 = [θ0, θ0_vel]
    y0 = ArrayPartition([θ0_vel, θ0_acc])
    tspan = (0.0, 100.0)s
    prob = ODEProblem(f!, y0, tspan, k)
    sol = solve(prob)
    # Plot all variables vs time
    plot(sol)
    # Plot in phase space
    plot(solve(prob), vars=(1,2))
end
=#