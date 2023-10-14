--- battery.lua
-- Auxiliary functions for the battery widget within widgets/system.lua
---

local battery = {}

--- Returns icon for the battery, depending on both its capacity and status.
--
-- @param capacity capacity of the battery (in %)
-- @param status status of the battery (for example Charging or Discharging)
-- @return chosen icon
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
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
