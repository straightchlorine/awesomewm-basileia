local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi

local theme = {}

--- make colors external
--theme.master_width_factor = 0.8
theme.fg_normal     = '#f5c7a8'
theme.bg_normal     = '#102e3e'

theme.useless_gap   = dpi(4)
theme.border_width  = dpi(1)

beautiful.init(theme)
