--- connect.lua
-- Connects all the custom signals and handles
-- them when caught.
---

local log = require('utility.logging')
require('utility.paths')

--- Logs active tag into file.
-- File is located in $HOME/.cache/awesomewm/<x>-active-tag
-- where <x> is the id of the display, where tag was
-- selected.
awesome.connect_signal('tag_selected', function(tag)
  local screen_id = tostring(tag.screen.index)
  local path = paths[tostring(screen_id) .. '-active-tag']
  log.log_to_file(path, tag.name)
end)

require('utility.tag-overview')

--- Logs workspace overview into JSON file.
-- File is located in $HOME/.cache/awesomewm/tag-overview
-- and contains overview (its display, id and number of
-- clients) of all tags on every display managed by window
-- manager, updated each time new client is open or moved
-- to another tag.
awesome.connect_signal('client_tagged', function(tag)
  local json = get_workspaces()
  local path = paths.tag_overview
  log.log_to_file(path, json)
end)
