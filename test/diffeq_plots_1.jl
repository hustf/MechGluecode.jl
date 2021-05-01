using Test
using MechGluecode
using MechanicalUnits
using MechanicalUnits: Unitfu.promote_to_derived
@import_expand(m, s, N) # Takes long if defined late)
using DifferentialEquations


@testset "Unitful time with unitful function" begin
    u0 = 30.0N
    tspan = (0.0, 10.0)s
    prob1 = ODEProblem((du,u,t,p) -> (du[1] = -0.2∙s⁻¹ * u[1]), [u0], tspan)
    prob2 = ODEProblem((u,t,p)    ->         (-0.2∙s⁻¹ * u[1]), u0, tspan)
    prob3 = ODEProblem((u,t,p)    ->         [-0.2∙s⁻¹* u[1]], [u0],tspan)
    so1 =  solve(prob1, Euler(), dt = 1s)
    so2 =  solve(prob2, Midpoint())
    so3 =  solve(prob3, Tsit5())
    plot(so1, denseplot = false, marker = true)
    plot(so2, denseplot = false, marker = true)
    plot(so3, denseplot = false, marker = true)
    sf1(t) = so1(t)[1]
    sf2(t) = so2(t)[1]
    sf3(t) = so3(t)[1]
    plot([sf1, sf2, sf3], xlims =(0,10)s, ylims =(0,40)N)
    plot([t-> sf1(t) / sf3(t), t-> sf2(t) / sf3(t)], xlims =(0,10)s, ylims = (0.5,1.1), minorgrid=true, grid = (:y, :olivedrab, :dot, 1, 0.9))

end
@testset "Unitful time with unitless function" begin
    u0 = 30.0
    tspan = (0.0, 10.0)s
    prob1 = ODEProblem((du,u,t,p) -> (du[1] = -0.2∙s⁻¹ * u[1]), [u0], tspan)
    prob2 = ODEProblem((u,t,p)    ->         (-0.2∙s⁻¹ * u[1]), u0, tspan)
    prob3 = ODEProblem((u,t,p)    ->         [-0.2∙s⁻¹* u[1]], [u0],tspan)
    so1 =  solve(prob1, Euler(), dt = 1s)
    so2 =  solve(prob2, Midpoint())
    so3 =  solve(prob3, Tsit5())
    # don't work plot(so1, denseplot = false, marker = true)
    # don't work plot(so2, denseplot = false, marker = true)
    # don't work plot(so3, denseplot = false, marker = true)
    sf1(t) = so1(t)[1]
    sf2(t) = so2(t)[1]
    sf3(t) = so3(t)[1]
    plot([sf1, sf2, sf3], xlims =(0,10)s, ylims =(0,40))
    plot([t-> sf1(t) / sf3(t), t-> sf2(t) / sf3(t)], xlims =(0,10)s, ylims = (0.5,1.1), minorgrid=true, grid = (:y, :olivedrab, :dot, 1, 0.9))
end

@testset "Plot ODE quantity" begin
    # Don't give us kN from from solution in this case, just defaults.
    promote_to_derived()
    f1 = (y, p, t) -> -1.5y / 0.3s
    u0 = 1.5N
    tspan = (0.0s, 1.0s)
    prob = ODEProblem(f1, u0, tspan)
    sol = solve(prob)
    plot(sol)
end

@testset "Plot ODE system same quantities" begin
    # This is not a good example, as the units are incorrect and have no
    # known physical interpretation
    σ = 10/s
    ρ = 28m
    β = (8 / 3)m
    function lorenz!(du, u, p, t)
        du[1] = (u[2] - u[1])∙σ
        du[2] = (u[1] * (ρ - u[3])) / (m∙s) - u[2]/s
        du[3] =  u[1] * u[2] / (m∙s)    - β ∙ u[3]/(m∙s)
    end
    u0 = [1.0, 0.0, 0.0]m
    tspan = (0.0,100.0)s
    prob = ODEProblem(lorenz!,u0,tspan)
    sol = solve(prob)
    # Plot all variables vs time
    plot(sol)
    # Plot in phase space
    plot(sol, vars=(1,2,3))
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