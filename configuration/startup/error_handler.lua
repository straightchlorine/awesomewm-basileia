local naughty = require('naughty')

local function error_handler()
  naughty.connect_signal('request::display_error', function(message, startup)
    naughty.notification {
      urgency = 'critical',
      title = 'one must imagine Sisiphus happy' .. (startup and ' at the feet of the mountain...' or '...'),
      message = message
    }
  end)
end

error_handler()
