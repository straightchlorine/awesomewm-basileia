--- taglist.lua
-- Attached a taglist widget to given screen object.
---

local awful = require 'awful'
local env = require 'utility.environment'

--- Get an array of buttons used by taglist widget.
--
-- Standard taglist keybindings from the documentation
-- [https://awesomewm.org/apidoc/sample%20files/rc.lua.html]
--
-- @return list of buttons for taglist widget
local function buttons()
  modkey = env.modkey
  return {
    awful.button({}, 1, function(t)
      t:view_only()
    end),
    awful.button({ modkey }, 1, function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
    end),
    awful.button({}, 4, function(t)
      awful.tag.viewprev(t.screen)
    end),
    awful.button({}, 5, function(t)
      awful.tag.viewnext(t.screen)
    end),
  }
end

local taglist = {}

--- Attach taglist widget to given screen.
--
-- @param s screen object
function taglist.attach(s)
  s.taglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = buttons(),
  }
end

return taglist
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
