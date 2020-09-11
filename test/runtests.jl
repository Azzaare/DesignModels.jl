using DesignModels
using Test

import DesignModels.Design, DesignModels.Facet

@testset "DesignModels.jl" begin
    design = Design()
    facet = Facet()
    # println(convert_design("../examples/ascii.stl"; compact=false))
    for f in [
        "ascii",
        "primitive closed box",
        "primitive floor",
        "primitive open box"
        ]
        convert_design("../examples/$f.stl"; file = "../examples/$f.json")
    end

end
