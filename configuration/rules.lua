local ruled = require('ruled')
local awful = require('awful')

ruled.client.connect_signal('request::rules', function()
  -- global rule
  ruled.client.append_rule {
    id         = 'global',
    rule       = { },
    properties = {
      size_hints_honor = false,
      honor_workarea = true,
      honor_padding = true,
      raise     = true,
      focus     = awful.client.focus.filter,
      screen    = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  }

  -- floating clients
  ruled.client.append_rule {
    id       = 'floating',
    rule_any = {
      instance = { 'copyq', 'pinentry' },
      class    = {
        'Arandr', 'Blueman-manager', 'Gpick', 'Kruler', 'Sxiv',
        'Tor Browser', 'Wpa_gui', 'veromix', 'xtightvncviewer'
      },
      name    = {
        'Event Tester',  -- xev.
      },
      role    = {
        'AlarmWindow',    -- Thunderbird's calendar.
        'ConfigManager',  -- Thunderbird's about:config.
        'pop-up',         -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = { floating = true }
  }

  -- eww widgets
  ruled.client.append_rule({
    rule_any = {
      class = {
        'eww',
        'Eww'
      },
      name = {
        'Eww - horizontal-bar',
        'Eww - vertical-bar'
      }
    },
    properties = {
      valid = false,
      focusable = false,
      skip_taskbar = true,
      border_width = 0,
    },
  })

  -- steam
  ruled.client.append_rule({
    rule_any = {
      class = {
        'steam',
        'steamwebhelper'
      }
    },
    properties = {
      screen = screen.count(),
      tag = '10',
      ontop = true,
      x = 890,
      y = 355,
    },
  })

  -- steam friend list
  ruled.client.append_rule({
    rule_any = {
      name = {
        'Friends List'
      }
    },
    properties = {
      x = 1655,
      y = 434,
      floating = true,
      ontop = true,
      width = 226,
      height = 571
    },
  })

  -- steam client
  ruled.client.append_rule({
    rule_any = {
      name = {
        'Steam'
      }
    },
    properties = {
      x = 9,
      y = 54,
      ontop = true,
      floating = true,
      width = 1902,
      height = 1017
    },
  })

end)
