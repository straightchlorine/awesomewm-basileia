--- connect.lua
-- Connects all the custom signals and handles
-- them when caught.
---

local debug = require('utility.deubg')
local log = require('utility.logging')

--- Logs active tag into file.
-- File is locate in $HOME/.cache/awesomewm/<x>-active-tag
-- where <x> is the id of the display, where tag was
-- selected.
awesome.connect_signal('tag_selected', function(tag)
  local screen_id = tostring(tag.screen.index)
  local path = os.getenv('HOME') ..
    '/.cache/awesomewm/' ..
    screen_id .. '-active-tag'
  log.log_to_file(path, tag.name)
end)

--- Logs workspace overview into file.
awesome.connect_signal('client_tagged', function(tag)

end)
