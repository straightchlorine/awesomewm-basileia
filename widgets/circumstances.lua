--- circumstances.lua
-- Widgets containing basic information such as time and date.
---

local env = require('utility.environment')

local awful = require('awful')
local wibox = require('wibox')

local circumstances = {}

--- Get widget displaying time and date.
--
-- For example:
--  Friday, 22 Septempber 19:04:50
--
-- @return wibox.widget.textclock providing date and time
function circumstances.time_and_date ()

  local time_and_date = wibox.widget.textclock('%A, %d %B %T', 1)
  time_and_date.forced_width = 200
  return time_and_date

end

--- Get widget displaying current weather conditions.
--
-- Example output:
--   14°C
--
-- @return awful.widget.watch with information about current weather
function circumstances.weather()

  local weather = awful.widget.watch(env.scripts.widgets.weather, 180)
  weather.forced_width = 50
  return weather

end

--- Get widget displaying date, time and weather conditions
--
-- Essentialy combines time_and_date() and weather() widgets, while adding
-- a separator before both of them, so the widget looks more or less centered.
--
-- In order to see whether screen in question is vertically or horizontally
-- aligned method from utility/bar_management is used.
--
-- Note: that only 1920x1080 and 1080x1920 resolutions are taken into account.
--
-- TODO: respectable method, which calculates how big separator should be
-- regardless of the resolution.
--
-- Output would be similar to the following:
--  Friday, 22 Septempber 19:04:50      14°C
--
-- @param s screen object in order to determine its orientation
-- @return awful.widget object containing time and date along with weather
function circumstances.status(s)

  return {
    wibox.widget {
      widget = wibox.widget.separator,
      thickness = 0,
      forced_width = require('utility.bar-management').is_vertical(s) and 90 or 710
    },
    circumstances.time_and_date(),
    circumstances.weather(),
    layout = wibox.layout.align.horizontal,
  }

end

return circumstances
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
