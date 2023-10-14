--- default-applications.lua
-- Provides an object, containing applications which are often used.
---

local paths = require('utility.paths')

local defaults = {
  emulator = 'kitty',
  browser = 'firefox',
  music_player = 'kitty -e ncmpcpp',
  launcher = paths.rofi,
  rotate_display = paths.rotation,
  screenshot_utility = paths.rofi_utils.screenshot_utility,
  powermenu = paths.rofi_utils.powermenu,
  mpd_manager = {
    play_pause = 'mpc toggle',
    previous = 'mpc prev',
    next = 'mpc next',
    volume_up = 'mpc volume +2',
    volume_down = 'mpc volume -2',
    toggle_mute = 'pactl set-sink-mute @DEFAULT_SINK@ toggle',
    mpd_rofi_popup = paths.rofi_utils.mpd_controller
  }
}

return defaults

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
