--- circumstances.lua
-- Contains functions providing widgets with information
-- about the time, weather etc.
---

local awful = require('awful')
local wibox = require('wibox')

local circumstances = {}

function circumstances.time_and_date ()

  local time_and_date = wibox.widget.textclock('%A, %d %b %T', 1)
  time_and_date.forced_width = 180
  return time_and_date

end

return circumstances
