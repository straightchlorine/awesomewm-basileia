--- default-applications.lua
-- Provides an object, containing applications which are often used.
---

local env = require 'utility.environment'

local defaults = {
  emulator = 'kitty',
  browser = 'firefox',
  music_player = 'kitty -e ncmpcpp',
  launcher = env.rofi.launcher,
  rotate_display = env.scripts.rotation,
  screenshot_utility = env.rofi.screenshot_utility,
  powermenu = env.rofi.powermenu,
  mpd_manager = {
    play_pause = 'mpc toggle',
    previous = 'mpc prev',
    next = 'mpc next',
    volume_up = 'mpc volume +2',
    volume_down = 'mpc volume -2',
    toggle_mute = 'pactl set-sink-mute @DEFAULT_SINK@ toggle',
  },
}

return defaults

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
