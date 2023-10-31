--- widgets/init.lua
-- Initializes widgets.
---

local bars = require('widgets.bars')
local eww = require('utility.eww.integration')

--- Attach native awesomewm widgets.
local function native()
  screen.connect_signal('request::desktop_decoration', function(s)
    if s.index == 1 then
      bars.main_bar(s)
    else
      bars.side_bar(s)
    end
  end)
end

local env = require('utility.environment')

--- Provide appropriate widgets.
--
-- If the eww integration is desired i.e. env.enable_integration is true, then
-- eww widgets are provided. Otherwise, standard awesomewm widget configuration
-- is utilised.
local function widgets()
  if env.eww.enable_integration then
    eww.setup()
  else
    native()
  end
end

widgets()
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
