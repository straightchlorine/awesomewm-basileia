local awful = require('awful')

--- Count clients on a given tag.
-- For each given tag function iterates through its clients
-- and returns the sum.
-- @param tag given tag
-- @return sum of the clients from tag
function count_clients(tag)
  local count = 0
  for _, c in ipairs(tag:clients()) do
    count = count + 1
  end
  return count
end

--- Generate JSON describing each workspace.
-- Iterates through both the screens and tags, with information
-- about the screen, tag and number of clients in a particular
-- workspace.
-- @return JSON file with states of all the workspaces
function get_workspaces()
  -- final JSON output
  local json = '{"display":[%s]}'

  local displays = ''
  awful.screen.connect_for_each_screen(function (s)
    local display = '{"id":%d,"workspaces":[%s]}'
    local workspaces = ''

    -- gather information from every tag in the screen
    for _, tag in ipairs(s.tags) do
      local workspace = '{"id":%d,"windows":%d}'
      workspace = string.format(workspace, tag.index, count_clients(tag))
      workspaces = workspaces..((workspaces == '') and '' or ',')..workspace
    end

    -- append gathered data
    display = string.format(display, s.index, workspaces)
    displays = displays..((displays == '') and '' or ',')..display
  end)

  return string.format(json, displays)
end
