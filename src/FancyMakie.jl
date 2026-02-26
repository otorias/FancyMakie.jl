"""
# FancyMakie.jl

Basic utilities for plotting with CairoMakie

## Exported functions / macros
    
    set_custom_theme!()

    mm2pt(x,y)

    comma(str)

    wbox(axis, limits)

    cross()

    U"..."

"""
module FancyMakie
__precompile__()

using CairoMakie, LaTeXStrings, MathTeXEngine

const fg_theme = Theme(size = (453.54,340.15), fontsize = 12)
const ax_theme = Theme(Axis = (
    xminorticks = IntervalsBetween(2),
    yminorticks = IntervalsBetween(2),
    xtickalign = 1,
    ytickalign = 1,
    xticksize = 4,
    yticksize = 4,
    xminortickalign = 1,
    yminortickalign = 1,
    xminorticksize = 2.5,
    yminorticksize = 2.5,
    xticksmirrored = true,
    yticksmirrored = true,
    xminorticksvisible = true,
    yminorticksvisible = true,
    xgridvisible = false,
    ygridvisible = false,
    xminorgridvisible = false,
    yminorgridvisible = false
))
const lb_theme = Theme(Label = (valign = :top, halign = :left, padding = (5,5,5,5)))
const eb_theme = Theme(Errorbars = (whiskerwidth = 5, linewidth = 1))
const lg_theme = Theme(Legend = (position = :rt, margin = (1,1,1,1), framevisible=false, rowgap=-5, merge=true))
const plot_theme = merge(fg_theme, ax_theme, lg_theme, eb_theme, lb_theme)

const ax_theme_map = Theme(Axis = (   
    xminorticks = IntervalsBetween(2),
    yminorticks = IntervalsBetween(2),
    xtickalign = 0,
    ytickalign = 0,
    xticksize = 4,
    yticksize = 4,
    xminortickalign = 0,
    yminortickalign = 0,
    xminorticksize = 2.5,
    yminorticksize = 2.5,
    xminorticksvisible = true,
    yminorticksvisible = true,
    xgridvisible = false,
    ygridvisible = false,
    xminorgridvisible = false,
    yminorgridvisible = false
))
const cb_theme = Theme(Colorbar = (vertical=true, flipaxis=true))
const heatmap_theme = merge(fg_theme, ax_theme_map)

function theme_utopiafonts()
    utopia_theme = Theme(
        font = joinpath(@__DIR__, "fonts", "Erewhon-Regular.otf"),
        fonts = (;
            regular     = joinpath(@__DIR__, "fonts", "Erewhon-Regular.otf"),
            bold        = joinpath(@__DIR__, "fonts", "Erewhon-Bold.otf"),
            italic      = joinpath(@__DIR__, "fonts", "Erewhon-Italic.otf"),
            bold_italic = joinpath(@__DIR__, "fonts", "Erewhon-BoldItalic.otf"),
        ),
    )
    return utopia_theme
end

const latex_string_replacements = [
    "\\alpha"      => "\\textit{\\alpha}",      "\\otheralpha"      => "\\text{\\alpha}",
    "\\beta"       => "\\textit{\\beta}",       "\\otherbeta"       => "\\text{\\beta}",
    "\\gamma"      => "\\textit{\\gamma}",      "\\othergamma"      => "\\text{\\gamma}",      "\\Gamma"          => "\\textit{\\Gamma}",      "\\otherGamma"      => "\\text{\\Gamma}",
    "\\delta"      => "\\textit{\\delta}",      "\\otherdelta"      => "\\text{\\delta}",      "\\Delta"          => "\\textit{\\Delta}",      "\\otherDelta"      => "\\text{\\Delta}",
    "\\epsilon"    => "\\textit{\\epsilon}",    "\\otherepsilon"    => "\\text{\\epsilon}",    "\\varepsilon"     => "\\textit{\\varepsilon}", "\\othervarepsilon" => "\\text{\\varepsilon}",
    "\\zeta"       => "\\textit{\\zeta}",       "\\otherzeta"       => "\\text{\\zeta}",
    "\\eta"        => "\\textit{\\eta}",        "\\othereta"        => "\\text{\\eta}",
    "\\theta"      => "\\textit{\\theta}",      "\\othertheta"      => "\\text{\\theta}",      "\\vartheta"       => "\\textit{\\vartheta}",   "\\othervartheta"   => "\\text{\\vartheta}",   "\\Theta" => "\\textit{\\Theta}", "\\otherTheta" => "\\text{\\Theta}",
    "\\iota"       => "\\textit{\\iota}",       "\\otheriota"       => "\\text{\\iota}",
    "\\kappa"      => "\\textit{\\kappa}",      "\\otherkappa"      => "\\text{\\kappa}",      "\\varkappa"       => "\\textit{\\varkappa}",   "\\othervarkappa"   => "\\text{\\varkappa}",
    "\\lambda"     => "\\textit{\\lambda}",     "\\otherlambda"     => "\\text{\\lambda}",     "\\Lambda"         => "\\textit{\\Lambda}",     "\\otherLambda"     => "\\text{\\Lambda}",
    "\\mu"         => "\\textit{\\mu}",         "\\othermu"         => "\\text{\\mu}",
    "\\nu"         => "\\textit{\\nu}",         "\\othernu"         => "\\text{\\nu}",
    "\\xi"         => "\\textit{\\xi}",         "\\otherxi"         => "\\text{\\xi}",         "\\Xi"             => "\\textit{\\Xi}",         "\\otherXi"         => "\\text{\\Xi}",
    "\\pi"         => "\\textit{\\pi}",         "\\otherpi"         => "\\text{\\pi}",         "\\varpi"          => "\\textit{\\varpi}",      "\\othervarpi"      => "\\text{\\varpi}",      "\\Pi"    => "\\textit{\\Pi}",    "\\otherPi"    => "\\text{\\Pi}",
    "\\rho"        => "\\textit{\\rho}",        "\\otherrho"        => "\\text{\\rho}",        "\\varrho"         => "\\textit{\\varrho}",     "\\othervarrho"     => "\\text{\\varrho}",
    "\\sigma"      => "\\textit{\\sigma}",      "\\othersigma"      => "\\text{\\sigma}",      "\\varsigma"       => "\\textit{\\varsigma}",   "\\othervarsigma"   => "\\text{\\varsigma}",   "\\Sigma" => "\\textit{\\Sigma}", "\\otherSigma" => "\\text{\\Sigma}",
    "\\tau"        => "\\textit{\\tau}",        "\\othertau"        => "\\text{\\tau}",
    "\\upsilon"    => "\\textit{\\upsilon}",    "\\otherupsilon"    => "\\text{\\upsilon}",    "\\Upsilon"        => "\\textit{\\Upsilon}",    "\\otherUpsilon"    => "\\text{\\Upsilon}",
    "\\phi"        => "\\textit{\\phi}",        "\\otherphi"        => "\\text{\\phi}",        "\\varphi"         => "\\textit{\\varphi}",     "\\othervarphi"     => "\\text{\\varphi}",     "\\Phi"   => "\\textit{\\Phi}",   "\\otherPhi"   => "\\text{\\Phi}",
    "\\chi"        => "\\textit{\\chi}",        "\\otherchi"        => "\\text{\\chi}",
    "\\psi"        => "\\textit{\\psi}",        "\\otherpsi"        => "\\text{\\psi}",        "\\Psi"            => "\\textit{\\Psi}",        "\\otherPsi"        => "\\text{\\Psi}",
    "\\omega"      => "\\textit{\\omega}",      "\\otheromega"      => "\\text{\\omega}",      "\\Omega"          => "\\textit{\\Omega}",      "\\otherOmega"      => "\\text{\\Omega}",

    "+" => "\\textit{+}", "-" => "\\textit{-}", "\\pm" => "\\textit{\\pm}", "=" => "\\textit{=}", "\\times" => "\\textit{\\times}", "\\div" => "\\textit{\\div}", "°" => "\\textit{°}" 
]

# Helper function for [see below]
function change_latex_string(lat_str::LaTeXString)
    active_math_font = MathTeXEngine.get_texfont_family().fonts[:math]
    if occursin("Erewhon", active_math_font)
        new_str = replace(lat_str.s, latex_string_replacements...)
        return LaTeXString(new_str)
    end
    return lat_str
end    

@doc raw"""
    U"..."

Like L"..." from LaTeXStrings.jl but improved for use with Utopia (Erewhon) fonts\\
and is identical to L"..." if Makie font is not set to `:utopia`.\\
Allows for upright greek letters with "\\othergreek".

# Examples
```juliarepl
julia> U"d = 0.5\,\othermu\mathrm{m}"
"$d = 0.5\,\text{\mu}\mathrm{m}$" ("d = 0.5 μm")

julia> U"\sigma_\othergamma = %$(12.34^2) \mathrm{b}"
"$\textit{\sigma}_\text{\gamma} = 152.2756 \mathrm{b}$" ("σ_γ = 152.2756 b")
```
"""
macro U_str(s::String)
    # 1. Create a hard-coded pointer to the original macro. 
    original_macro = GlobalRef(LaTeXStrings, Symbol("@L_str"))
    # 2. Manually construct the code expression to call it
    mac_call = Expr(:macrocall, original_macro, __source__, s)

    return quote
        # 3. Escape the call so %$ variables are found in the user's script
        lat_str = $(esc(mac_call))
        # 4. Pass the result to our helper function
        $FancyMakie.change_latex_string(lat_str) 
    end
end

"""
    set_custom_theme!(theme::Symbol=:plot; font::Symbol=:latex)

Sets the global Makie theme to the defined theme of this package.

# Available themes:
- `:plot`: for creating usuals 2D plots
- `:heatmap`: specifically for heatmap-plots where the axis-ticks should not go inside the axis

If function is called without theme it defaults to `:plot`.

# Available fonts:
- `:latex`: Computer Modern
- `:utopia`: Erewhon (Similar to Utopia)
"""
function set_custom_theme!(theme::Symbol=:plot; font::Symbol=:latex)
    if theme === :plot
        custom_theme = FancyMakie.plot_theme
    elseif theme === :heatmap
        custom_theme = FancyMakie.heatmap_theme
    else
        error(":$theme not defined; try :plot or :heatmap")
    end

    if font === :latex
        MathTeXEngine.set_texfont_family!()
        set_theme!(merge(custom_theme, theme_latexfonts()))
    elseif font === :utopia
        MathTeXEngine.set_texfont_family!(
            regular    = joinpath(@__DIR__, "fonts", "Erewhon-Regular.otf"),
            bold       = joinpath(@__DIR__, "fonts", "Erewhon-Bold.otf"),
            italic     = joinpath(@__DIR__, "fonts", "Erewhon-Italic.otf"),
            bolditalic = joinpath(@__DIR__, "fonts", "Erewhon-BoldItalic.otf"),
            math       = joinpath(@__DIR__, "fonts", "Erewhon-Math.otf")
        )
        set_theme!(merge(custom_theme, theme_utopiafonts()))
    else
        error(":$font not defined; try :latex or :utopia")
    end
end

"""
    mm2pt(x,y)

Calculates the size a figure needs to result in desired mm.

# Examples
```julia-repl
julia> mm2pt(160,120)
(453.5433070866142, 340.15748031496065)

julia> figure = Figure(size=mm2pt(160,120), fontsize=12)
...
julia> save("output.pdf", figure, pt_per_unit=1)
# saves a vector graphic of width 16 cm, height 12 cm and fontsize 12
```
"""
mm2pt(x,y) = (x,y) ./ 25.4 .* 72 # mm -> inches -> pt

"""
    comma(str::String)

Replaces all points in a string with commas

# Examples
```julia-relp
julia> comma("12.3")
"12,3"

julia> using FancyData, Measurements
julia> value = 98.76 ± 0.54
julia> str = mes(value)
"98.8(5)"
julia> comma(str)
"98,8(5)"
```
"""
comma(str)=replace(str,'.'=>',')

"""
    wbox(ax, limits)

Plots white box in axis `ax`.
Limits are given as an array similar to axis.limits but in relative space.

# Examples
```julia-repl
julia> wbox(axis, [0.1, 0.2, 0.1, 0.2])
# small box in the bottom left corner

julia> wbox(axis, [0.5, 1.0, 0.5, 1.0])
# large box taking up the right top quadrant
```
"""
function wbox(ax,limits)
    poly!(ax,Point2f[(limits[1],limits[3]),
                     (limits[2],limits[3]),
                     (limits[2],limits[4]),
                     (limits[1],limits[4])],
        space=:relative,
        color=:white,
        strokewidth=0.6,
        strokecolor=:black,
        linestyle=:solid
    )
end

"""
    cross()

Can be used as a substitute for `:cross` as a marker.

# (Optional) Arguments:
- `length`: default=1
- `width`: default=1
- `rotation`: default=0, given in radians

# Examples
```julia-repl
julia> scatter!(x_values, y_values, marker=cross())

julia> scatterlines!(x_values, y_values, marker=cross(rotation=pi/4))
```
"""
function cross(;length=1,width=1,rotation=0)
    l=0.5length
    w=0.12width
    α=rotation
    BezierPath([
    MoveTo([cos(α) -sin(α);sin(α) cos(α)]*Point(  0,  w)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(l-w,  l)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(  l,l-w)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(  w,  0)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(  l,w-l)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(l-w, -l)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(  0, -w)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(w-l, -l)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point( -l,w-l)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point( -w,  0)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point( -l,l-w)),
    LineTo([cos(α) -sin(α);sin(α) cos(α)]*Point(w-l,  l)),
    ClosePath()
    ])
end

function __init__()
    # runs at runtime
    @eval Makie begin # make line and Marker elements of uniform size
        function legendelements(plot::Union{Lines, LineSegments}, legend)
            ls = plot.linestyle[]
            return LegendElement[
                LineElement(
                    plots = plot,
                    color = extract_color(plot, legend[:linecolor]),
                    linestyle = choose_scalar(ls isa Vector ? Linestyle(ls) : ls, legend[:linestyle]),
                    linewidth = 1,#choose_scalar(plot.linewidth, legend[:linewidth]),
                    colormap = plot.colormap,
                    colorrange = plot.colorrange,
                    alpha = plot.alpha
                ),
            ]
        end

        function legendelements(plot::Scatter, legend)
            return LegendElement[
                MarkerElement(
                    plots = plot,
                    color = extract_color(plot, legend[:markercolor]),
                    marker = choose_scalar(plot.marker, legend[:marker]),
                    markersize = 5,#choose_scalar(plot.markersize, legend[:markersize]),
                    strokewidth = choose_scalar(plot.strokewidth, legend[:markerstrokewidth]),
                    strokecolor = choose_scalar(plot.strokecolor, legend[:markerstrokecolor]),
                    colormap = plot.colormap,
                    colorrange = plot.colorrange,
                    alpha = plot.alpha,
                ),
            ]
        end
        
        # make legendelement for errorbars actually errorbars
        function legendelements(plot::Errorbars, legend)
            w = 1.0   # horizontal bar length
            h = 0.2   # whisker height
        
            # Define points centered at (0,0)
            points = Point2f[
                (-w/2,  h/2), (-w/2, -h/2),   # left whisker
                (-w/2,   0),  ( w/2,   0),    # horizontal bar
                ( w/2,  h/2), ( w/2, -h/2)    # right whisker
            ]
            # Shift all points so the glyph is centered at (0.5,0.5)
            points .= points .+ Point2f(0.5, 0.5)
        
            return [LineElement(
                plots = plot,
                color = extract_color(plot, legend[:linecolor]),
                linewidth = 1,#choose_scalar(plot.linewidth, legend[:linewidth]),
                colormap = plot.colormap,
                colorrange = plot.colorrange,
                alpha = plot.alpha,
                points = points
               )]
        end
    end
end


export set_custom_theme!, mm2pt, comma, wbox, cross, @U_str

end # module
