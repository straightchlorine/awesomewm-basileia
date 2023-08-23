--- default-applications.lua
-- returns array of commonly used applications

local home_directory = os.getenv('HOME')

local defaults = {
  emulator = 'kitty',
  browser = 'firefox',
  music_player = 'kitty -e ncmpcpp',
  launcher = home_directory .. '/.config/rofi/launchers/type-4/launcher.sh'
}

return defaults
