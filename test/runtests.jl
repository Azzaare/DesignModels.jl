using DesignModels
using Test

import DesignModels.Design, DesignModels.Facet

@testset "DesignModels.jl" begin
    design = Design()
    facet = Facet()
    # println(convert_design("../examples/ascii.stl"; compact=false))
    convert_design("../examples/ascii.stl"; compact=false, file = "../examples/ascii.json")
end
