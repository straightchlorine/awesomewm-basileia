--- error-handler.lua
-- Provides basic error handling for the window manager.
---

local naughty = require('naughty')

--- If an error is caught, notification is displayed along with the message.
local function error_handler()
  naughty.connect_signal('request::display_error', function(message, startup)
    naughty.notification {
      urgency = 'critical',
      title = 'One must imagine Sisiphus happy' .. (startup and ' at the feet of the mountain...' or '...'),
      message = message
    }
  end)
end

error_handler()

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
