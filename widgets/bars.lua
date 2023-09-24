--- bars.lua
-- Contains variants of wibar system bars.
---

local awful = require('awful')
local wibox = require('wibox')

local system = require('widgets.system')
local circumstances = require('widgets.circumstances')

local bars = {}

--- Attach new main bar to the  screen.
--
-- It displays taglist, current time, date and weather, data received and
-- transmitted through network interface, how much of root partition is 
-- occupied (in %), ram usage (in %) and cpu usage(in %).
--
-- @param s screen object to attach to
-- @param modkey usually windows key
function bars.main_bar (s, modkey)

  -- attach the taglist to the screen
  require('widgets.taglist').attach(s, modkey)

  -- attach bar to the screen
  s.bar = awful.wibar {
    position = 'top',
    screen = s,
    widget = {
      layout = wibox.layout.align.horizontal,
      {
        s.taglist,
        layout = wibox.layout.align.horizontal
      },
      {
        circumstances.status(s),
        layout = wibox.layout.align.horizontal
      },
      {
        system.status(),
        layout = wibox.layout.align.horizontal
      }
    }
  }

end

--- Attach new side bar to the screen.
-- It displays taglist, current time, date and weather.
--
-- @param s screen object to attach to
-- @param modkey usually windows key
function bars.side_bar (s, modkey)

  -- attach the taglist to the screen
  require('widgets.taglist').attach(s, modkey)

  -- attach bar to the screen
  s.bar = awful.wibar {
    position = 'top',
    screen = s,
    widget = {
      layout = wibox.layout.align.horizontal,
      {
        s.taglist,
        layout = wibox.layout.align.horizontal
      },
      wibox.widget {
        widget = wibox.widget.separator,
        thickness = 0,
      },
      {
        circumstances.status(s),
        layout = wibox.layout.align.horizontal
      }
    }
  }

end

return bars
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
