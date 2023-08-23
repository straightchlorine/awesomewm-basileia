--- binds.lua

local awful = require('awful')
local gears = require('gears')

--- keybindings popup
local hotkeys_popup = require('awful.hotkeys_popup')
require("awful.hotkeys_popup.keys")

local defaults = require('configuration.default-applications')

-- aliases
local ctrl = 'Control'
local enter = 'Return'
local shift = 'Shift'
local alt = 'Mod1'
local mod = 'Mod4'

--- general keybindings
awful.keyboard.append_global_keybindings({
	awful.key({ mod, ctrl, shift }, 'r',
    awesome.restart,
  { description = 'restart', group = 'general' }),
	awful.key({ mod, ctrl, shift }, 'q',
    awesome.quit,
  { description = 'quit', group = 'general' }),
	awful.key({ mod }, 'F1',
    hotkeys_popup.show_help,
  { description = 'this message', group = 'general' }),
	awful.key({ mod }, enter, function()
		awful.spawn(defaults.emulator)
	end, { descrpion = 'terminal', group = 'key' }),
	awful.key({ mod }, 'r', function()
		awful.spawn.with_shell(defaults.launcher)
	end, { desciption = 'application launcher', group = 'key' }),
  -- TODO: add another bind for rotating the screen and switching
  -- eww bars from horizontal to vertical (vice versa)
})

-- focus by direction
awful.keyboard.append_global_keybindings({
  -- vim
  awful.key({ mod }, 'k', function()
		awful.client.focus.bydirection('up')
	end, { description = 'focus up', group = 'focus' }),
	awful.key({ mod }, 'j', function()
		awful.client.focus.bydirection('down')
	end, { description = 'focus down', group = 'focus' }),
	awful.key({ mod }, 'h', function()
		awful.client.focus.bydirection('left')
	end, { description = 'focus left', group = 'focus' }),
	awful.key({ mod }, 'l', function()
		awful.client.focus.bydirection('right')
	end, { description = 'focus right', group = 'focus' }),

  -- arrows
  awful.key({ mod }, 'Up', function()
		awful.client.focus.bydirection('up')
	end, { description = 'focus up', group = 'focus' }),
	awful.key({ mod }, 'Down', function()
		awful.client.focus.bydirection('down')
	end, { description = 'focus down', group = 'focus' }),
	awful.key({ mod }, 'Left', function()
		awful.client.focus.bydirection('left')
	end, { description = 'focus left', group = 'focus' }),
	awful.key({ mod }, 'Right', function()
		awful.client.focus.bydirection('right')
	end, { description = 'focus right', group = 'focus' }),
})

-- resizing
local utility = require('utility.client')

awful.keyboard.append_global_keybindings({
  -- vim
	awful.key({ mod, ctrl }, 'k', function(c)
    utility.resize(client.focus, 'up')
	end, { description = 'resize up', group = 'size' }),
	awful.key({ mod, ctrl }, 'j', function(c)
		utility.resize(client.focus, 'down')
	end, { description = 'resize down', group = 'size' }),
	awful.key({ mod, ctrl }, 'h', function(c)
    utility.resize(client.focus, 'left')
	end, { description = 'resize left', group = 'size' }),
	awful.key({ mod, ctrl }, 'l', function(c)
		utility.resize(client.focus, 'right')
	end, { description = 'resize right', group = 'size' }),

  -- arrows
	awful.key({ mod, ctrl }, 'Up', function(c)
		utility.resize(client.focus, 'up')
	end, { description = 'resize up', group = 'size' }),
	awful.key({ mod, ctrl }, 'Down', function(c)
		utility.resize(client.focus, 'down')
	end, { description = 'resize down', group = 'size' }),
	awful.key({ mod, ctrl }, 'Left', function(c)
		utility.resize(client.focus, 'left')
	end, { description = 'resize left', group = 'size' }),
	awful.key({ mod, ctrl }, 'Right', function(c)
		utility.resize(client.focus, 'right')
	end, { description = 'resize right', group = 'size' }),
})

-- hardware
awful.keyboard.append_global_keybindings({
	awful.key({}, 'XF86MonBrightnessUp', function()
		awful.spawn('brightnessctl set 5%+ -q', false)
	end, { description = 'brightness up', group = 'hardware' }),
	awful.key({}, 'XF86MonBrightnessDown', function()
		awful.spawn('brightnessctl set 5%- -q', false)
	end, { description = 'brightness down', group = 'hardware' }),
	awful.key({}, 'XF86AudioRaiseVolume', function()
		awful.spawn('amixer sset Master 5%+', false)
	end, { description = 'volume up', group = 'hardware' }),
	awful.key({}, 'XF86AudioLowerVolume', function()
		awful.spawn('amixer sset Master 5%-', false)
	end, { description = 'volume down', group = 'hardware' }),
	awful.key({}, 'XF86AudioMute', function()
		awful.spawn('amixer sset Master toggle', false)
	end, { description = 'volume mute', group = 'hardware' }),

  -- update
	--awful.key({}, 'XF86AudioPlay', function()
	--	playerctl_daemon:play_pause()
	--end, { description = 'play/pause music', group = 'music' }),
	--awful.key({}, 'XF86AudioPrev', function()
	--	playerctl_daemon:previous()
	--end, { description = 'previous music', group = 'music' }),
	--awful.key({}, 'XF86AudioNext', function()
	--	playerctl_daemon:next()
	--end, { description = 'next music', group = 'music' }),
})

-- layout
awful.keyboard.append_global_keybindings({
	awful.key({ mod, shift }, 's', function()
    local layout_function = awful.layout.get(mouse.screen)
    local layout_name = awful.layout.getname(layout_function)

    if layout_name ~= 'floating' then
      awful.layout.set(awful.layout.suit.floating)
    else
      awful.layout.set(awful.layout.suit.fair)
    end
	end, { description = 'toggle floating', group = 'layout' }),
  awful.key({ mod }, 'space', function ()
    awful.layout.inc(1)
  end, { description = 'select next', group = 'layout' }),
  awful.key({ mod, shift }, 'space', function ()
    awful.layout.inc(-1)
  end, { description = 'select previous', group = 'layout' }),
})


