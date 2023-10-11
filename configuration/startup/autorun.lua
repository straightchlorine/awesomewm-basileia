--- autorun.lua
-- Directs the initial startup of the window manager.
---

local awful = require('awful')
local paths = require('utility.paths')
local eww   = require('utility.eww-integration')

--- Startup function.
local function autorun ()
  awful.spawn.with_shell(paths.autorun)

  -- NOTE: runs only if variable paths.eww is set to true  
  eww.setup()
end

autorun()
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
