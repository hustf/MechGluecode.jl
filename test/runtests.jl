using Test
include("plots_1.jl")
include("diffeq_1.jl")
include("diffeq_plots_1.jl")
include("diffeq_plots_2.jl")

#=
using SnoopCompileCore
list = []
@testset "Plots" begin
    push!(list, @snoopr include("plots.jl"))
end
@testset "DifferentialEquations" begin
    push!(list, @snoopr include("differential_equations.jl"))
end
using SnoopCompile

invalidations = list[1]
length(uinvalidated(invalidations))
trees = invalidation_trees(invalidations)
length(trees)
ftrees = filtermod(MechGluecode, trees)
ftrees = filtermod(MechGlueDiffEq, trees)


[(length(trees[i].backedges), i) for i in 1:37] |> sort!

method_invalidations = trees[34]
length(method_invalidations.backedges)
root = method_invalidations.backedges[1]
show(root; minchildren=0)

=#