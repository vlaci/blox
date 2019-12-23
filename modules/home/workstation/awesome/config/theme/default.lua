-- Theme is based on https://github.com/lcpz/awesome-copycats.git Powerarrow-dardk
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local gcol = require("gears.color")
local surface = require("gears.surface")
local shape = require("gears.shape")

local lain_helpers = require("lain.helpers")


-- {{{ Main
-- inherit default theme
local theme = dofile(gfs.get_themes_dir() .. "zenburn/theme.lua")
theme.dir = gfs.get_configuration_dir() .. "theme/"
theme.wallpaper = theme.dir .. "wall.png"
-- }}}

-- {{{ Styles
theme.font      = "Sans 8"
theme.tooltip_font      = "Sans 10"

-- {{{ Colors
theme.alpha = "B0"
theme.fg_normal                                 = "#DDDDFF"
theme.fg_focus                                  = "#EA6F81"
theme.fg_urgent                                 = "#CC9393"
theme.bg_normal                                 = "#353535" .. theme.alpha
theme.bg_focus                                  = "#2C2C2C" .. theme.alpha
theme.bg_urgent                                 = "#1A1A1A"

theme.wibar_bg   = theme.bg_focus
theme.bg_systray = theme.wibar_bg


-- }}}

-- {{{ Borders
theme.useless_gap   = dpi(32)
theme.border_width                              = dpi(2)
theme.border_normal                             = theme.bg_normal
theme.border_focus                              = theme.bg_focus
theme.border_marked                             = "#CC9393"
-- }}}

theme.tasklist_bg_normal   = "#00000000"
theme.tasklist_bg_focus    = "#00000000"
theme.tasklist_bg_urgent   = "#00000000"
theme.tasklist_bg_minimize = "#00000000"
theme.tasklist_align = "center"
theme.tasklist_max_button_size = dpi(300)
theme.tasklist_fg_focus   = theme.fg_normal
theme.tasklist_underline_size = dpi(3)

-- {{{ Titlebars
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_fg_normal = theme.fg_normal
theme.titlebar_fg_focus = theme.fg_normal
theme.titlebar_fg_hover = theme.fg_focus
theme.titlebar_fg_press = theme.fg_focus
theme.titlebar_fg_active = theme.fg_urgent
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}


-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]

theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)
-- }}}

-- {{{ Icons
-- {{{ Taglist
-- Generate taglist squares:
local taglist_square_size = dpi(6)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_underline_size = dpi(3)
theme.taglist_fg_focus   = theme.fg_normal
theme.taglist_bg_normal  = "#00000000"
theme.taglist_bg_focus   = "#00000000"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
-- }}}

-- {{{ Layout
-- }}}

-- {{{ Titlebar
theme = theme_assets.recolor_titlebar(theme, theme.titlebar_fg_normal, "normal")
theme = theme_assets.recolor_titlebar(theme, theme.titlebar_fg_hover, "normal", "hover")
theme = theme_assets.recolor_titlebar(theme, theme.titlebar_fg_press, "normal", "press")
theme = theme_assets.recolor_titlebar(theme, theme.titlebar_fg_focus, "focus")
theme = theme_assets.recolor_titlebar(theme, theme.titlebar_fg_hover, "focus", "hover")
theme = theme_assets.recolor_titlebar(theme, theme.titlebar_fg_press, "focus", "press")

local function match_color(color, image)
    local sfc = surface.duplicate_surface(image)
    return gcol.recolor_image(sfc, color)
end

theme.titlebar_ontop_button_focus_active  = match_color(theme.titlebar_fg_active, theme.titlebar_ontop_button_focus_active)
theme.titlebar_ontop_button_normal_active = match_color(theme.titlebar_fg_active, theme.titlebar_ontop_button_normal_active)

theme.titlebar_sticky_button_focus_active  = match_color(theme.titlebar_fg_active, theme.titlebar_sticky_button_focus_active)
theme.titlebar_sticky_button_normal_active = match_color(theme.titlebar_fg_active, theme.titlebar_sticky_button_normal_active)

theme.titlebar_floating_button_focus_active  = match_color(theme.titlebar_fg_active, theme.titlebar_floating_button_focus_active)
theme.titlebar_floating_button_normal_active = match_color(theme.titlebar_fg_active, theme.titlebar_floating_button_normal_active)

theme.titlebar_maximized_button_focus_active  = match_color(theme.titlebar_fg_active, theme.titlebar_maximized_button_focus_activ)
theme.titlebar_maximized_button_normal_active = match_color(theme.titlebar_fg_active, theme.titlebar_maximized_button_normal_active)
-- }}}
-- }}}

theme.lain_icons         = lain_helpers.icons_dir .. "layout/zenburn/"
theme.layout_termfair    = match_color(theme.fg_normal, theme.lain_icons .. "termfair.png")
theme.layout_centerfair  = match_color(theme.fg_normal, theme.lain_icons .. "centerfair.png")  -- termfair.center
theme.layout_cascade     = match_color(theme.fg_normal, theme.lain_icons .. "cascade.png")
theme.layout_cascadetile = match_color(theme.fg_normal, theme.lain_icons .. "cascadetile.png") -- cascade.tile
theme.layout_centerwork  = match_color(theme.fg_normal, theme.lain_icons .. "centerwork.png")
theme.layout_centerhwork = match_color(theme.fg_normal, theme.lain_icons .. "centerworkh.png") -- centerwork.horizontal

theme = theme_assets.recolor_layout(theme, theme.fg_normal)

theme.tags_internet = theme.dir .. "icons/tags-internet.png"
theme.tags_term = theme.dir .. "icons/tags-term.png"
theme.tags_develop = theme.dir .. "icons/tags-develop.png"
theme.tags_doc = theme.dir .. "icons/tags-doc.png"
theme.tags_files = theme.dir .. "icons/tags-files.png"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
