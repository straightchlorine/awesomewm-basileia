--- debug.lua
-- Debugging utility, for quick troubleshooting.
---
local naughty = require 'naughty'

local debug = {}

--- Print quick notification with debug message.
--
-- @param msg Message to be displayed.
function debug.notifyDebug(msg)
  naughty.notify {
    preset = naughty.config.presets.normal,
    title = '-- debug --',
    text = tostring(msg),
  }
end

return debug
