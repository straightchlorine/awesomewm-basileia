--- tags.lua
-- Defines layouts and tags themselves.
---

local awful = require('awful')

-- default layouts
tag.connect_signal("request::default_layouts", function()
  awful.layout.append_default_layouts({
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.top,
    awful.layout.suit.tile.bottom,
  })
end)

local signals = require('signals.tag-signals')

-- attach tags and layouts to each screen
screen.connect_signal('request::desktop_decoration', function(s)
  awful.tag({ '1', '2', '3', '4','5','6' ,'7', '8', '9', '10'}, s, awful.layout.layouts[1])
  signals.connect_signals(s.tags)
end)
