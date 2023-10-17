--- widgets/init.lua
-- Initializes widgets.
---

local bars = require('widgets.bars')
local env = require('utility.environment')
local eww = require('utility.eww.integration')

--- Provides appropriate to the current configuration widgets.
--
-- If the eww integration is desired i.e. env.enable_integration is true, then
-- eww widgets are provided. Otherwise, standard awesomewm widget configuration
-- is utilised.
local function widgets()
  if  env.eww.enable_integration then
    eww.setup()
  else
    screen.connect_signal('request::desktop_decoration', function(s)
      if s.index == 1 then
        bars.main_bar(s, env.modkey)
      else
        bars.side_bar(s, env.modkey)
      end
    end)
  end
end

widgets()
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
