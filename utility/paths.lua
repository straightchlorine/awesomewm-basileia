--- paths.lua
-- Contains paths to files used as a handles
-- for eww scripts to read.
---

local debug = require('utility.deubg')
paths = {}

local root_folder = os.getenv('HOME') .. '/.cache/awesomewm/'

for i = 1, screen.count() do
  local name = tostring(i) .. '-active-tag'
  paths[name] = root_folder .. name
end

paths.tag_overview = root_folder .. 'tag-overview'
