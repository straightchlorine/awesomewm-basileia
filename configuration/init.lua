local gears = require('gears')
local path = gears.filesystem.get_configuration_dir() .. 'configuration/'

require(... .. '.default-applications')
require(... .. '.binds')
require(... .. '.tags')
