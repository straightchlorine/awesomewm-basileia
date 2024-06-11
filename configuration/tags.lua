--- tags.lua
-- Defines layouts and tags.
---

local awful = require("awful")

-- setting default layouts
tag.connect_signal("request::default_layouts", function()
	awful.layout.append_default_layouts({
		awful.layout.suit.tile,
		awful.layout.suit.fair,
		awful.layout.suit.tile.top,
		awful.layout.suit.tile.bottom,
		awful.layout.suit.tile.left,
		awful.layout.suit.tile.right,
	})
end)

-- defining and attaching tags to each screen
screen.connect_signal("request::desktop_decoration", function(s)
	awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }, s, awful.layout.layouts[1])
end)
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
