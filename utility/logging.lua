--- logging.lua
-- Utility managing interactions between awesomewm
-- and other external files.

require('utility.paths')
require('utility.tag-overview')
local logger = {}

function logger.log_to_file(file_path, content)
  local file = io.open(file_path, 'w')
  if file then
    file:write(tostring(content))
    file:close()
  end
end

local function set_base_overview()
  local content = get_workspaces()
  local file = io.open(paths.tag_overview, 'w')

  if file then
    file:write(content)
    file:close()
  end
end

local function set_base_tags()
  for i = 1, screen.count() do
    local active_tag = tostring(i) .. '-active-tag'
    local file = io.open(paths[active_tag], 'w')

    if file then
      file:write(tostring(1))
      file:close()
    end
  end
end

function logger.base_files()
  set_base_overview()
  set_base_tags()
end

return logger
