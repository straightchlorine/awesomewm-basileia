--- connect.lua
-- Connects signals and handles them when caught.
---

local awful = require 'awful'

--- Enables sloppy focus.
client.connect_signal('mouse::enter', function(c)
  c:emit_signal('request::activate', 'mouse_enter', { raise = false })
end)

--- Immediate focus for new clients.
client.connect_signal('manage', function(c)
  awful.ewmh.activate(c, 'client')
end)
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
