--- default-applications.lua
-- returns array of commonly used applications

local gears = require('gears')

local home_directory = os.getenv('HOME')
local scripts = gears.filesystem.get_configuration_dir() ..
  'configuration/scripts/'

local defaults = {
  emulator = 'kitty',
  browser = 'firefox',
  music_player = 'kitty -e ncmpcpp',
  launcher = home_directory .. '/.config/rofi/launchers/type-4/launcher.sh',
  rotate_display = scripts .. 'toggle_rotation DisplayPort-0',
  mpd_manager = {
    play_pause = 'mpc toggle',
    previous = 'mpc prev',
    next = 'mpc next',
    volume_up = 'mpc volume +2',
    volume_down = 'mpc volume -2',
    toggle_mute = 'pactl set-sink-mute @DEFAULT_SINK@ toggle',
  }
}

return defaults
