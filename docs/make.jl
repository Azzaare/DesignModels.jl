using DesignModels
using Documenter

makedocs(;
    modules=[DesignModels],
    authors="azzaare <jf@baffier.fr> and contributors",
    repo="https://github.com/azzaare/DesignModels.jl/blob/{commit}{path}#L{line}",
    sitename="DesignModels.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://azzaare.github.io/DesignModels.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/azzaare/DesignModels.jl",
)
