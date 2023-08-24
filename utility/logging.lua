--- logging.lua
-- 

local logger = {}

function logger.log_to_file(file_path, content)
  local file = io.open(file_path, 'w')

  if file then
    file:write(tostring(content))
    file:close()
  end
end

return logger
