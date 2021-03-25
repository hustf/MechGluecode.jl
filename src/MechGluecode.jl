module MechGluecode
using MechanicalUnits
using Requires

function __init__()
    @require DifferentialEquations = "0c46a032-eb83-5123-abaf-570d42b7fbaa" @eval using MechGlueDiffEqBase
    @require Interpolations = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59" @eval using MechGlueInterpolations
    @require ModelingToolkit = "961ee093-0014-501f-94e3-6117800e7a78" @eval using MechGlueModelingToolkit
    @require Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80" @eval using MechGluePlots
    @require RecursiveArrayTools = "731186ca-8d62-57ce-b412-fbd966d074cd" @eval using MechGlueRecursiveArrayTools
end
end
