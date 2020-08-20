
StructTypes.StructType(::Type{Coord}) = StructTypes.ArrayType()

StructTypes.names(::Type{Facet}) = (
    (:normal, :normal),
    (:loop, :loop)
)
StructTypes.StructType(::Type{Facet}) = StructTypes.Struct()

StructTypes.names(::Type{Design}) = (
    (:facets, :facets),
)
StructTypes.StructType(::Type{Design}) = StructTypes.Struct()