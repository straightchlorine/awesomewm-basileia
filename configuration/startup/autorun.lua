--- autorun.lua
-- Startup of the window manager.
---

local awful = require("awful")
local env = require("utility.environment")

awful.spawn.with_shell(env.scripts.autorun)
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
