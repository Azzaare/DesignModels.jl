module DesignModels

## Import Automa.jl for parsing stl strings
import Automa
import Automa.RegExp: @re_str
# Define the notation for RegExp in Automa.jl
const re = Automa.RegExp
# Concatenation with spaces: \times (tab completion)
× = (x::re.RE, y::re.RE) -> x * re"[\t\n\r ]+" * y

# Exports
export import_design

# Includes
include("design.jl")
include("stl.jl")

"""
    import_design(path::String; format = :stl)
Import a design to internal format. Default to `.stl` designs.
"""
function import_design(path::String; format=:stl)
    if format == :stl
        return parse_stl(read(path, String))[1]
    end
end

end
