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

-- multihead
awful.keyboard.append_global_keybindings({
  awful.key({ mod, alt }, "l", function ()
    awful.screen.focus_relative(1)
  end, { description = "focus the next screen", group = "display" }),
  awful.key({ mod, alt }, "h", function ()
    awful.screen.focus_relative(-1)
  end, { description = "focus the previous screen", group = "display" })
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

-- mouse
client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({
		awful.button({}, 1, function(c)
			c:activate({ context = "mouse_click" })
		end),
		awful.button({ mod }, 1, function(c)
			c:activate({ context = "mouse_click", action = "mouse_move"})
		end),
		awful.button({ mod }, 3, function(c)
			c:activate({ context = "mouse_click", action = "mouse_resize"})
		end),
	})
end)

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
	--  playerctl_daemon:play_pause()
	--end, { description = 'play/pause music', group = 'music' }),
	--awful.key({}, 'XF86AudioPrev', function()
	--  playerctl_daemon:previous()
	--end, { description = 'previous music', group = 'music' }),
	--awful.key({}, 'XF86AudioNext', function()
	--  playerctl_daemon:next()
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

-- tag
awful.keyboard.append_global_keybindings({
	awful.key({
		modifiers = { mod },
		keygroup = 'numrow',
		description = 'toggle last tag',
		group = 'tag',
		on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]

      if tag then
        if tag == screen.selected_tag then
          awful.tag.history.restore()
        else
          tag:view_only()
        end
      end
    end,
	}),
	awful.key({
		modifiers = { mod, shift },
		keygroup = 'numrow',
		description = 'move client to tag',
		group = 'tag',
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	}),
})

-- client
client.connect_signal('request::default_keybindings', function()
  awful.keyboard.append_global_keybindings({
    -- swapping (vim)
    awful.key({ mod, shift }, 'k', function(c)
      awful.client.swap.bydirection('up', c, nil)
    end),
    awful.key({ mod, shift }, 'j', function(c)
      awful.client.swap.bydirection('down', c, nil)
    end),
    awful.key({ mod, shift }, 'h', function(c)
      awful.client.swap.bydirection('left', c, nil)
    end),
    awful.key({ mod, shift }, 'l', function(c)
      awful.client.swap.bydirection('right', c, nil)
    end),

    -- swapping (arrows)
    awful.key({ mod, shift }, 'Up', function(c)
      awful.client.swap.bydirection('up', c, nil)
    end),
    awful.key({ mod, shift }, 'Down', function(c)
      awful.client.swap.bydirection('down', c, nil)
    end),
    awful.key({ mod, shift }, 'Left', function(c)
      awful.client.swap.bydirection('left', c, nil)
    end),
    awful.key({ mod, shift }, 'Right', function(c)
      awful.client.swap.bydirection('right', c, nil)
    end),

    -- toggle floating
    awful.key({ mod, ctrl }, 'space',
      awful.client.floating.toggle
    ),

    -- toggle fullscreen
    awful.key({ mod }, 'f', function()
      client.focus.fullscreen = not client.focus.fullscreen
      client.focus:raise()
    end),

    awful.key({ mod }, 'n', function()
      client.focus.minimized = true
    end, { description = 'minimize', group = 'client' }),

    awful.key({ mod, ctrl }, 'n', function()
      local c = awful.client.restore()
      if c then
        c:activate({ raise = true, context = 'key.unminimize' })
      end
    end, { description = 'unminimize', group = 'client' }),

    -- on top
    awful.key({ mod }, 'p', function()
      client.focus.ontop = not client.focus.ontop
    end),

    -- close window
    awful.key({ mod }, 'q', function()
      client.focus:kill()
    end),

    -- center window
    awful.key({ mod }, 'c', function()
      awful.placement.centered(client.focus, { honor_workarea = true, honor_padding = true })
    end),
  })
end)
