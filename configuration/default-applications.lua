--- default-applications.lua
-- returns array of commonly used applications

local gears = require('gears')

local scripts = gears.filesystem.get_configuration_dir() ..'configuration/scripts/'
local rofi_applets = os.getenv('HOME') .. '/.config/rofi/applets/bin/'

local defaults = {
  emulator = 'kitty',
  browser = 'firefox',
  music_player = 'kitty -e ncmpcpp',
  launcher = os.getenv('HOME') .. '/.config/rofi/launchers/type-4/launcher.sh',
  rotate_display = scripts .. 'toggle_rotation DisplayPort-0',
  screenshot_utility = rofi_applets .. 'screenshot.sh',
  powermenu = rofi_applets .. 'powermenu.sh',
  mpd_manager = {
    play_pause = 'mpc toggle',
    previous = 'mpc prev',
    next = 'mpc next',
    volume_up = 'mpc volume +2',
    volume_down = 'mpc volume -2',
    toggle_mute = 'pactl set-sink-mute @DEFAULT_SINK@ toggle',
    mpd_rofi_popup = rofi_applets .. 'mpd.sh'
  }
}

return defaults
