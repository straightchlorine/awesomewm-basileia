--- circumstances.lua
-- Widgets containing basic information such as time and date.
---

local env = require 'utility.environment'

local awful = require 'awful'
local wibox = require 'wibox'

--- Module containing methods for various widgets providing information about
--- things such as time, date, weather, etc.
--
-- @module widgets.circumstances
local circumstances = {}

--- Get widget displaying time and date.
--
-- For example:
--  Friday, 22 Septempber 19:04:50
--
-- TODO: maybe add simple calendar widget as initially planned,
-- would definitely be convenient.
--
-- @treturn wibox.widget.textclock providing date and time
function circumstances.time_and_date()
  local time_and_date = wibox.widget.textclock(' %A, %d %B %T', 1)
  time_and_date.forced_width = 220
  return time_and_date
end

--- Get widget displaying current weather conditions.
--
-- Example output:
--   14°C
--
-- @treturn awful.widget.watch with information about current weather
function circumstances.weather()
  local weather = awful.widget.watch(env.scripts.widgets.weather.script, 180)
  weather.forced_width = 80
  return weather
end

--- Get widget displaying currently played by mpd song.
--
-- @treturn wibox.widget.textbox object containing currently played song
function circumstances.mpd()
  return require 'widgets.mpd'
end

--- Get widget displaying date, time and weather conditions.
--
-- Essentialy combines time_and_date() and weather() widgets, while adding
-- a separator before both of them, so the widget looks more or less centered.
--
-- Output would be similar to the following:
--  Friday, 22 Septempber 19:04:50      14°C
--
-- @treturn wibox.widget object containing time and date along with weather
function circumstances.status()
  return {
    circumstances.time_and_date(),
    circumstances.weather(),
    layout = wibox.layout.align.horizontal,
  }
end

--- Get widget displaying currently played by mpd song.
--
-- Uses circumstances.mpd() to get the widget and adds small separator on the
-- widget's left side.
--
-- @treturn wibox.widget object containing currently played song
function circumstances.music()
  return {
    wibox.widget {
      widget = wibox.widget.separator,
      thickness = 0,
      forced_width = 50,
    },
    circumstances.mpd(),
    layout = wibox.layout.align.horizontal,
  }
end

return circumstances
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
