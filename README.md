# MechGluecode

Glue code for the types defined in [Unitfu.jl](https://github.com/hustf/Unitfu.jl). The required packages are registered in [M8](https://github.com/hustf/M8).

The extension glue code is loaded if you also load:
    - DifferentialEquations.jl => load MechGlueDiffEqBase.jl
    - Plots.jl => load MechGluePlots.jl

Not completed yet:
    - Interpolations.jl => load MechGlueDiffEqBase.jl
    - Plots.jl => load MechGlueInterpolations.jl
    - ModelingToolkit => MechGlueModelingToolkit
    - [RecursiveArrayTools](https://github.com/SciML/RecursiveArrayTools.jl): This is included in MechGlueDiffEqBase, no standalone glue code needed (?)
