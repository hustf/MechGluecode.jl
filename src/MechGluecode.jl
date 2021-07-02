module MechGluecode
using Requires
export value, ODE_DEFAULT_NORM, UNITLESS_ABS2, Unitfu, norm

function __init__()
    @require MechanicalUnits = "e6be9192-89dc-11e9-36e6-5dbcb28f419e" begin
        @require Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80" begin
            @info "Plots => using MechGluePlots"
            @eval using MechGluePlots
        end
        @require Interpolations = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59" begin
            @info "Interpolations => using MechGlueInterpolations"
            @eval using MechGlueInterpolations
        end
        @require ModelingToolkit = "961ee093-0014-501f-94e3-6117800e7a78" begin
            #@info "ModelingToolkit => using MechGlueModelingToolkit"
            #@eval using MechGlueModelingToolkit
        end
        @require RecursiveArrayTools = "731186ca-8d62-57ce-b412-fbd966d074cd" begin
           # @info "RecursiveArrayTools => using MechGlueRecursiveArrayTools"
           # @eval using MechGlueDiffEqBase
           #  @info "RecursiveArrayTools => using MechGlueRecursiveArrayTools"
           #  @eval using MechGlueRecursiveArrayTools
        end
        @require DiffEqBase = "2b5f629d-d688-5b77-993f-72d75c75574e" begin
            @info "DiffEqBase => using MechGlueDiffEqBase"
            @eval using MechGlueDiffEqBase
        end
    end
    @info "MechGluecode init"
end
end
