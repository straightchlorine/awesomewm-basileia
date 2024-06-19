local naughty = require 'naughty'

local debug = {}

function debug.notifyDebug(msg)
  naughty.notify {
    preset = naughty.config.presets.normal,
    title = '-- debug --',
    text = tostring(msg),
  }
end

return debug
