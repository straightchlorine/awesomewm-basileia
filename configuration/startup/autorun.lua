local awful = require('awful')
local gears = require('gears')

local file_setup = require('utility.logging')

local script_path = gears.filesystem.get_configuration_dir() .. 'configuration/scripts/'

local function autorun ()
  awful.spawn.with_shell(script_path .. 'autorun')
  file_setup.base_files()
end

autorun()
