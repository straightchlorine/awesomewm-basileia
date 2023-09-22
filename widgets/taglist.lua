--- taglist.lua
-- Attached a taglist widget to given screen object.
---

local awful = require('awful')

--- Get an array of buttons used by taglist widget.
-- @return array of buttons
local function buttons(modkey)

  return {
    awful.button({ }, 1, function(t)
      t:view_only() 
    end),
    awful.button({ modkey }, 1, function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
    end),
    awful.button({ }, 4, function(t)
      awful.tag.viewprev(t.screen)
    end),
    awful.button({ }, 5, function(t)
      awful.tag.viewnext(t.screen)
    end),
  }

end

local taglist = {}

--- Attach taglist widget to given screen.
-- @param screen object
-- @param modkey key used as Mod in coniguration
function taglist.attach (s, modkey)

   s.workspaces = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = buttons(modkey)
  }

end

return taglist
