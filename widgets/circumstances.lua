--- circumstances.lua
-- Contains functions providing widgets with information
-- about the time, weather etc.
---

local awful = require('awful')
local wibox = require('wibox')

local circumstances = {}

-- path to the weather script
local weather_script = os.getenv('HOME') .. '/.config/awesome/widgets/scripts/weather'

--- Get awful.widget object displaying time and date.
--
-- @return awful.widget
function circumstances.time_and_date ()

  local time_and_date = wibox.widget.textclock('%A, %d %b %T', 1)
  time_and_date.forced_width = 160
  return time_and_date

end

--- Get awful.widget object displaying current weather.
--
-- @return awful.widget
function circumstances.weather ()

  local weather = awful.widget.watch(weather_script .. ' --prompt', 180)
  weather.forced_width = 60
  return weather

end

--- Merges both time and weather widgets into single object.
--
-- @return awful.widget
function circumstances.status()
  return {
    wibox.widget {
      widget = wibox.widget.separator,
      thickness = 0,
      forced_width = 710
    },
    circumstances.time_and_date(),
    circumstances.weather(),
    layout = wibox.layout.align.horizontal,
  }

end

return circumstances
