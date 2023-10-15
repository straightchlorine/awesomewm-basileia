--- widgets/init.lua
-- Initializes widgets.
---

local bars = require('widgets.bars')
local env = require('utility.environment')

--- Attaching appropirate bar to each screen
screen.connect_signal('request::desktop_decoration', function(s)
  if s.index == 1 then
    bars.main_bar(s, env.modkey)
  else
    bars.side_bar(s, env.modkey)
  end
end)
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
