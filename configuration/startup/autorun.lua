--- autorun.lua
-- Directs the initial startup of the window manager.
---

local awful = require('awful')
local env = require('utility.environment')
local eww = require('utility.eww-integration')

--- Startup function.
local function autorun ()
  awful.spawn.with_shell(env.scripts.autorun)

  -- NOTE: runs only if variable env.eww is set to true  
  eww.setup()
end

autorun()
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
