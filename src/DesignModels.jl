module DesignModels

## Import Automa.jl for parsing stl strings
import Automa
import Automa.RegExp: @re_str
# Define the notation for RegExp in Automa.jl
const re = Automa.RegExp
# Concatenation with spaces: \times (tab completion)
× = (x::re.RE, y::re.RE) -> x * re"[\t\n\r ]+" * y

# Import JSON3
import JSON3
import JSON3.StructTypes

# Exports
export import_design, export_design, convert_design

# Includes
include("design.jl")
include("stl.jl")
include("io.jl")

"""
    import_design(path::String; format = :stl)
Import a design to internal format. Default to `.stl` designs.
"""
function import_design(path::String; format=:stl)
    if format == :stl
        return parse_stl(read(path, String))[1]
    end
end

function export_design(design::Design; format=:json)
    if format == :json
        return JSON3.write(design)
    end
end

function convert_design(path::String; from=:stl, to=:json, file="")
    str = export_design(import_design(path; format=from); format=to)
    if file != ""
        write(file, str)
    end
    return str
end

end # module