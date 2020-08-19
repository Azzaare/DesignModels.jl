const stl_machine = (
    function () # Grammar
    # Basic regexp
    object      = re"OBJECT"
    space       = re"[\t\n\r ]"
    oct         = re"0o[0-7]+"
    dec         = re"[-+]?[0-9]+
    
    hex         = re"0x[0-9A-Fa-f]+"
    prefloat    = re"[-+]?([0-9]+\.[0-9]*|[0-9]*\.[0-9]+)"

    # Complex regexp
    float   = prefloat | re.cat(prefloat | re"[-+]?[0-9]+", re"[eE][-+]?[0-9]+")
    number  = oct | dec | hex | float
    coord   = number × number × number
    vertex  = re"vertex" × coord
    loop    = re"outer" × re"loop" * re.rep(space | vertex) * re"endloop"
    normal  = re"normal" × coord
    facet   = re"facet" × normal × loop × re"endfacet"
    solid   = re"solid" × object * re.rep(space | facet) * re"endsolid" × object
    list    = re.rep(space | solid)

    # RegExp/States Actions
    coord.actions[:enter]   = [:init_coord]
    facet.actions[:exit]    = [:add_facet]
    loop.actions[:enter]    = [:init_loop]
    normal.actions[:exit]   = [:new_facet]
    number.actions[:enter]  = [:mark]
    number.actions[:exit]   = [:store_coord]
    solid.actions[:exit]    = [:add_solid]
    vertex.actions[:exit]   = [:add_vertex]

    return Automa.compile(list)
end
)()

const stl_actions = Dict(
    :add_facet      => :(add_facet!(design, facet)),
    :add_solid      => :(), # TODO: handle several objects
    :add_vertex     => :(add_vertex!(facet, coord)),
    :init_coord     => :(coord = Vector{Float64}()),
    :init_loop      => :(),
    :mark           => :(mark = p),
    :new_facet      => :(facet = Facet(coord)),
    :store_coord    => :(push!(coord, round(parse(Float64, data[mark:p - 1]); digits=3))),
)

const stl_context = Automa.CodeGenContext()

@eval function parse_stl(data::String)
    # Variables to store data    
    coord = Vector{Float64}()
    facet = Facet()
    design = Design()

    # Marks
    mark = 0

    # generate code to initialize variables used by FSM
    $(Automa.generate_init_code(stl_context, stl_machine))

    # set end and EOF positions of data buffer
    p_end = p_eof = sizeof(data)
    
    # generate code to execute FSM
    $(Automa.generate_exec_code(stl_context, stl_machine, stl_actions))
    
    # check if FSM properly finished and returm the state of the FSM
    return design, cs == 0 ? :ok : cs < 0 ? :error : :incomplete
end