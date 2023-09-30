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

--- Returns status of the battery.
--
-- Note: uses acpi utility.
--
-- @return int current capacity
function battery.status()
  local status = [=[
    acpi -b |
    head -n 1 |
    sed 's/.*: //' |
    awk -F ',' '{print $1}' |
    tr -d ' ' |
    sed 's/%//'
  ]=]

  local battery_status = nil
  awful.spawn.easy_async_with_shell(status, function(out)
    battery_status = out
  end)

  return battery_status
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

--- Returns icon for battery, depending on capacity and status.
--
-- @param capacity current capacity of the battery (in %)
-- @param status current status of the battery (for example Charging)
-- @return str icon
function battery.icon(capacity, status)
  if status == 'Charging' then
    if capacity == 100 then
      return '󰂃'
    else
      return '󰂄'
    end
  else
    if capacity < 10 then
      return '󰂃'
    elseif capacity < 20 and capacity >= 10 then
      return '󰁺'
    elseif capacity < 30 and capacity >= 20 then
      return '󰁻'
    elseif capacity < 40 and capacity >= 30 then
      return '󰁼'
    elseif capacity < 50 and capacity >= 40 then
      return '󰁽'
    elseif capacity < 60 and capacity >= 50 then
      return '󰁾'
    elseif capacity < 70 and capacity >= 60 then
      return '󰁿'
    elseif capacity < 80 and capacity >= 70 then
      return '󰂀'
    elseif capacity < 90 and capacity >= 80 then
      return '󰂂'
    elseif capacity < 95 and capacity >= 90 then
      return '󰂂'
    elseif capacity <= 100 and capacity >= 95 then
      return '󰁹'
    end
  end
end

return battery
