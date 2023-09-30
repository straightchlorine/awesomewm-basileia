--- battery.lua
-- Functions required for the battery widget.
---

local awful = require('awful')
local battery = {}

--- Returns true if device is portable (i.e. has a battery).
--
-- Looks into /sys/class/power_supply folder, if empty device is assumed to not
-- be portable.
--
-- @return boolean
function battery.exists()
  awful.spawn.easy_async_with_shell('ls /sys/class/power_supply', function(out)
    if out == nil then
      return false
    else
      return true
    end
  end)
end

return battery
