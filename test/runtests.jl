using DesignModels
using Test

import DesignModels.Design, DesignModels.Facet

@testset "DesignModels.jl" begin
    design = Design()
    facet = Facet()
    design = import_design("../examples/ascii.stl")
    println("\nDesign")
    for facet in design.facets
        print("\tfacet\t⟂ $(facet.normal)\n\t\t")
        for vertex in facet.loop
            print("▷ $vertex ")
        end
        print("\n")
    end
end
