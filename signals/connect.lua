--- connect.lua
-- Connects all the custom signals and handles
-- them when caught.
-- [ Runs automatically via rc.lua ]
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

--- Enables sloppy focus.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter",
    { raise = false }
  )
end)

local awful = require('awful')

--- Immediate focus for new clients.
client.connect_signal("manage", function(c)
    awful.ewmh.activate(c, "client")
end)

local focus = require('utility.focus')

--- Handing the focus over to another client after killing.
client.connect_signal("unmanage", function(c)
  focus.first_tag()
end)
