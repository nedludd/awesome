---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "DejaVu Sans 8"

theme.bg_normal     = "#333333"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#B33C23"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "1"
theme.border_normal = "#535d6c"
theme.border_focus  = "#bf5134"
theme.border_marked = "#91231c"

-- There are another variables sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- Example:
--taglist_bg_focus = #ff0000

-- Display the taglist squares
theme.taglist_squares_sel = "/home/thermans/.config/awesome/theme/icons/taglist/squarez.png"
theme.taglist_squares_unsel = "/home/thermans/.config/awesome/theme/icons/taglist/squareza.png"

theme.tasklist_floating_icon = "/home/thermans/.config/awesome/theme/icons/tasklist/floatingw.png"

-- Variables set for theming menu
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/home/thermans/.config/awesome/theme/icons/submenu.png"
theme.menu_height   = "15"
theme.menu_width    = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--bg_widget    = #cc0000

-- Define the image to load
theme.titlebar_close_button_normal = "/home/thermans/.config/awesome/theme/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus = "/home/thermans/.config/awesome/theme/icons/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/home/thermans/.config/awesome/theme/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = "/home/thermans/.config/awesome/theme/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/home/thermans/.config/awesome/theme/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = "/home/thermans/.config/awesome/theme/icons/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/home/thermans/.config/awesome/theme/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = "/home/thermans/.config/awesome/theme/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/home/thermans/.config/awesome/theme/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = "/home/thermans/.config/awesome/theme/icons/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/home/thermans/.config/awesome/theme/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = "/home/thermans/.config/awesome/theme/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/home/thermans/.config/awesome/theme/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = "/home/thermans/.config/awesome/theme/icons/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/home/thermans/.config/awesome/theme/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = "/home/thermans/.config/awesome/theme/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/home/thermans/.config/awesome/theme/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = "/home/thermans/.config/awesome/theme/icons/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "nitrogen --restore" }

-- You can use your own layout icons like this:
theme.layout_fairh = "/home/thermans/.config/awesome/theme/icons/layouts/fairh.png"
theme.layout_fairv = "/home/thermans/.config/awesome/theme/icons/layouts/fairv.png"
theme.layout_floating = "/home/thermans/.config/awesome/theme/icons/layouts/floating.png"
theme.layout_magnifier = "/home/thermans/.config/awesome/theme/icons/layouts/magnifier.png"
theme.layout_max = "/home/thermans/.config/awesome/theme/icons/layouts/max.png"
theme.layout_fullscreen = "/home/thermans/.config/awesome/theme/icons/layouts/fullscreen.png"
theme.layout_tilebottom = "/home/thermans/.config/awesome/theme/icons/layouts/tilebottom.png"
theme.layout_tileleft = "/home/thermans/.config/awesome/theme/icons/layouts/tileleft.png"
theme.layout_tile = "/home/thermans/.config/awesome/theme/icons/layouts/tile.png"
theme.layout_tiletop = "/home/thermans/.config/awesome/theme/icons/layouts/tiletop.png"

theme.awesome_icon = "/home/thermans/.config/awesome/icons/awesome.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
