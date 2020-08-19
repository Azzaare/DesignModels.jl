Coord = Tuple{Float64,Float64,Float64}

struct Facet
    normal::Coord
    loop::Vector{Coord}
end
function Facet(normal::Coord)
    Facet(normal, Vector{Coord}())
end
function Facet()
    Facet(Coord([0., 0., 0.]))
end
function Facet(coord::Vector{Float64})
    if length(coord) == 3
        Facet(Coord(coord))
    else
        Facet()
    end
end

function add_vertex!(facet::Facet, vertex::Coord)
    push!(facet.loop, vertex)
end
function add_vertex!(facet::Facet, vertex::Vector{Float64})
    if length(vertex) == 3
        add_vertex!(facet, Coord(vertex))
    end
end

struct Design
    facets::Vector{Facet}
end
function Design()
    Design(Vector{Facet}())
end

function add_facet!(design::Design, facet::Facet)
    push!(design.facets, facet)
end