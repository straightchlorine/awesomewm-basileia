--- autorun.lua
-- Directs the initial startup of the window manager.
---

local awful = require('awful')
local env = require('utility.environment')

--- Startup function.
local function autorun ()
  awful.spawn.with_shell(env.scripts.autorun)
end

autorun()
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
