--- init.lua
-- Initializes chosen widgets.
---

local bars = require('widgets.bars')
local modkey = 'Mod4'

--- Attaching appropirate bar to each screen
screen.connect_signal("request::desktop_decoration", function(s)
  if s.index == 1 then
    bars.main_bar(s, modkey)
  else
    bars.side_bar(s, modkey)
  end
end)
