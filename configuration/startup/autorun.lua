local awful = require('awful')
local gears = require('gears')

local script_path = gears.filesystem.get_configuration_dir() .. 'configuration/scripts/'

local function autorun ()

  awful.spawn.with_shell(script_path .. 'autorun')

end

autorun()
