using Documenter

# For reproducibility
mkpath("./docs/src/assets")
cp("./docs/Manifest.toml", "./docs/src/assets/Manifest.toml", force = true)
cp("./docs/Project.toml", "./docs/src/assets/Project.toml", force = true)

# for binder
using Literate
OUTPUT_MD = joinpath(@__DIR__, "src")
OUTPUT_NB = joinpath(@__DIR__, "src/notebooks")
OUTPUT_JL = joinpath(@__DIR__, "src/scripts")
files = [
    "index.jl",
    "bistable.jl",
    "oscillator.jl",
]
for file ∈ files
    INPUT = joinpath(@__DIR__, "src-literate", file)
    Literate.markdown(INPUT, OUTPUT_MD)
    Literate.notebook(INPUT, OUTPUT_NB)
    Literate.script(INPUT, OUTPUT_JL)
end

# 
repo_url = "github.com/agustinyabo/PWLdynamics.jl"

makedocs(;
    draft=false, # if draft is true, then the julia code from .md is not executed
    # to disable the draft mode in a specific markdown file, use the following:
    # ```@meta
    # Draft = false
    # ```
    remotes=nothing,
    warnonly=:cross_references,
    sitename="PWLdynamics",
    format=Documenter.HTML(;
        repolink="https://" * repo_url,
        prettyurls=false,
        size_threshold_ignore=[
            "index.md", 
            "bistable.md", 
            "oscillator.md"
        ],
        assets=[
            asset("https://control-toolbox.org/assets/css/documentation.css"),
            asset("https://control-toolbox.org/assets/js/documentation.js"),
        ],
    ),
    pages=[
        "Introduction" => "index.md",
        "Bistable toggle switch" => "bistable.md",
        "Damped genetic oscillator" => "oscillator.md",
    ],
)

deploydocs(; 
    push_preview=true,
    repo=repo_url * ".git", 
    devbranch="main")
