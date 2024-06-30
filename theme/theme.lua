--- theme.lua
-- Colorscheme configuration, now managed via colorgen.
-- [https://github.com/straightchlorine/colorgen]
---

local beautiful = require 'beautiful'
local dpi = beautiful.xresources.apply_dpi

-- local theme = {}
local theme = dofile(os.getenv 'HOME' .. '/.config/awesome/theme/themes/mountain-peak-light.lua')

theme.useless_gap = dpi(12)
theme.border_width = dpi(2)

beautiful.init(theme)

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
