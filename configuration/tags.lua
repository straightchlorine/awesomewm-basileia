local awful = require('awful')

-- default layouts
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
      awful.layout.suit.fair,
      awful.layout.suit.fair.horizontal
    })
end)

screen.connect_signal('request::desktop_decoration', function(s)
    awful.tag({ '1', '2', '3', '4','5','6' ,'7', '8', '9', '10'}, s, awful.layout.layouts[1])
end)
