--- bars.lua
-- Contains variants of wibar system bars.
---

local awful = require('awful')
local wibox = require('wibox')

local system = require('widgets.system')
local circumstances = require('widgets.circumstances')

--- Module defining main and side bars.
--
-- @module widgets.bars
local bars = {}

--- Attach new main bar to the  screen.
--
-- It displays taglist, current time, date and weather, data received and
-- transmitted through network interface, how much of root partition is 
-- occupied (in %), ram usage (in %) and cpu usage(in %).
--
-- @tparam screen s object to attach to
function bars.main_bar (s)

  -- attach the taglist to the screen
  require('widgets.taglist').attach(s)

  -- attach bar to the screen
  s.bar = awful.wibar {
    position = 'top',
    screen = s,
    widget = {
      halign = 'center',
      expand = 'none',
      {
        s.taglist,
        circumstances.music(),
        layout = wibox.layout.align.horizontal
      },
      {
        circumstances.status(),
        layout = wibox.layout.align.horizontal
      },
      {
        system.status(),
        layout = wibox.layout.align.horizontal
      },
      layout = wibox.layout.align.horizontal,
    }
  }

end

--- Attach new side bar to the screen.
-- It displays taglist, current time, date and weather.
--
-- @tparam screen s object to attach to
function bars.side_bar (s)

  -- attach the taglist to the screen
  require('widgets.taglist').attach(s)

  -- attach bar to the screen
  s.bar = awful.wibar {
    position = 'top',
    screen = s,
    widget = {
      {
        circumstances.status(),
        layout = wibox.layout.align.horizontal
      },
      wibox.widget {
        widget = wibox.widget.separator,
        thickness = 0,
      },
      {
        s.taglist,
        layout = wibox.layout.align.horizontal
      },
      layout = wibox.layout.align.horizontal,
    }
  }

end

return bars

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
