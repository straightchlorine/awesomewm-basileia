--- widgets/init.lua
-- Initializes widgets.
---

local bars = require('widgets.bars')
local paths = require('utility.paths')

--- Attaching appropirate bar to each screen
screen.connect_signal('request::desktop_decoration', function(s)
  if s.index == 1 then
    bars.main_bar(s, paths.modkey)
  else
    bars.side_bar(s, paths.modkey)
  end
end)
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
