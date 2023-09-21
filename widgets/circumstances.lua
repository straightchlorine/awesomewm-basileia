--- circumstances.lua
-- Contains functions providing widgets with information
-- about the time, weather etc.
---

local awful = require('awful')
local wibox = require('wibox')

local circumstances = {}

-- path to the weather script
local weather_script = os.getenv('HOME') .. '/.config/awesome/widgets/scripts/weather'

function circumstances.time_and_date ()

  local time_and_date = wibox.widget.textclock('%A, %d %b %T', 1)
  time_and_date.forced_width = 170
  return time_and_date

end

function circumstances.weather ()

  local weather = awful.widget.watch(weather_script .. ' --prompt', 180)
  weather.forced_width = 30
  return weather

end

return circumstances
