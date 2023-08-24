--- focus.lua
-- Functions handling focus management, 
-- if necessary.

local awful = require('awful')

local focus = {}

function focus.first_tag()
  local tag = awful.screen.focused().selected_tag
  if tag then
    local first_client = tag:clients()[1]
    if first_client then
      client.focus = first_client
      first_client:raise()
    end
  end
end

return focus

