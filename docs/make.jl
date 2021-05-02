using Documenter
using QOptCtrl

makedocs(
    sitename = "QOptCtrl",
    format = Documenter.HTML(),
    modules = [QOptCtrl]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
