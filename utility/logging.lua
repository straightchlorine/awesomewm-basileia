--- logging.lua
-- Utility managing interactions between awesomewm
-- and other external files.

local paths = require('utility.paths')
local logger = {}

function logger.log_to_file(file_path, content)
  local file = io.open(file_path, 'w')
  if file then
    file:write(tostring(content))
    file:close()
  end
end

return logger
