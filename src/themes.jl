const fg_theme = Theme(size = (453.54,340.15), fontsize = 12, backgroundcolor=:transparent)
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
    yminorgridvisible = false,
    backgroundcolor = :transparent
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
    yminorgridvisible = false,
    backgroundcolor = :transparent
))
const cb_theme = Theme(Colorbar = (vertical=true, flipaxis=true))
const heatmap_theme = merge(fg_theme, ax_theme_map)
