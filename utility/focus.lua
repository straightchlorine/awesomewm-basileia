--- focus.lua
-- Functions handling focus if necessary.

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

function focus.move_to_top(c)
  if c.floating then
    c:raise()
  end
end

return focus
