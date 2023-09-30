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

--- Returns percentage of battery capacity.
--
-- Note: uses acpi utility.
--
-- @return int current capacity
function battery.capacity()
  local capacity = [=[
    acpi -b | 
    head -n 1 | 
    sed 's/.*: //' | 
    awk -F ',' '{print $2}' | 
    tr -d ' ' | 
    sed 's/%//'
  ]=]

  local capacity_percentage = nil
  awful.spawn.easy_async_with_shell(capacity, function(out)
    capacity_percentage = out
  end)

  return tonumber(capacity_percentage)
end

return battery
