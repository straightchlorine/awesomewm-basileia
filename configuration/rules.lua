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
    },
  })

  -- steam
  ruled.client.append_rule({
    rule_any = {
      class = {
        'steamwebhelper',
      },
      name = {
        'Steam',
      }
    },
    properties = {
      tag = screen[screen.count()].tags[10]
    },
  })

  -- discord
  ruled.client.append_rule({
    rule_any = {
      class = {
        'discord',
      },
    },
    properties = {
      tag = screen[screen.count()].tags[9],
      floating = true,
      width = 1144,
      height = 610,
      placement = awful.placement.centered
    },
  })

end)