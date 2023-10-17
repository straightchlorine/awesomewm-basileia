--- files.lua
-- Helper methods related to file interaction.
---

local file = {}

--- Logs given content to given file.
--
-- @param path given log file, if does not exists, is created
-- @param content what needs to be saved within the file
function file.log(path, content)

  local f = io.open(path, 'w')
  if f then
    f:write(tostring(content))
    f:close()
  end

end

--- Checks if given file exists on the drive.
--
-- @param file being verified
function file.exists(path)

   local ok, err, code = os.rename(path, path)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return false

end

--- Checks if given directory exists on the drive.
-- 
-- @param path given directory
function file.isdir(path)
   return (file.exists(path .. '/'))
end

return file
