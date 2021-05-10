using Test
import MechanicalUnits: @import_expand, ∙, Quantity
@import_expand(m, s, N) # Takes long if defined late)
using MechGluecode
import Plots
using Plots: plot
import MechGluecode

@testset "Plots mixed quantity" begin
    s1x = [1.0,2,3]
    s2x = [1.0,2,3.5]
    s1y = [1.0,2,4]
    s2y = [1.0,2,2]
    mxqm = hcat(s1x∙m, s2x∙m²)
    myqm = hcat(s1y∙s, s2y∙s²)
    plot(mxqm, myqm, seriestype = [:path :scatter], label = ["path" "scatter"], xguide = "x", yguide = "y")
end

@testset "Plots functions with mixed units" begin
    f_q_q(t::Quantity) = sin(0.3∙2π∙t / s) ∙ 9.81N
    s_1_down  = range(20, 0, length = 100)
    s_1_up = range(0, 20, length = 100)
    s_2_down = range(8, 1, length = 100)
    s_2_up =  range(1, 8, length = 100)
    plot( xlims =(-5s, 5s),
        [f_q_q  x-> 0.5f_q_q(1.5x)∙m],
        ribbon = ([s_1_down∙N  s_2_down∙N∙m], [s_1_up∙N   s_2_up∙N∙m]),
        yguide = "Load", xguide = "Time")
end


