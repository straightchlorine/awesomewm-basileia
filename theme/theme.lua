local beautiful = require 'beautiful'
local dpi = beautiful.xresources.apply_dpi

local theme = {}

--- TODO: make coloring external, managed via script

theme.fg_normal = '#f5c7a8'
theme.bg_normal = '#102e3e'

theme.useless_gap = dpi(12)
theme.border_width = dpi(1)

--- taglist coloring
theme.taglist_bg_focus = '#83a598'
theme.taglist_bg_occupied = '#3e5f74'

beautiful.init(theme)
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
