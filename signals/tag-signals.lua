local debug = require('utility.deubg')
local tag_signals = {}

--- Set given tag to emit signal each time it is selected.
function tag_signals.signal_selection(t)
  t:connect_signal("property::selected", function(tag)
    awesome.emit_signal("tag_selected", tag)
  end)
end

--- Set given tag to emit signal each time client is open within the tag.
function tag_signals.signal_client_tagged(t)
  t:connect_signal("tagged", function(client)
    awesome.emit_signal("client_tagged", t)
  end)
end

function tag_signals.connect_signals(tags)
  for _, t in ipairs(tags) do
    tag_signals.signal_selection(t)
    tag_signals.signal_client_tagged(t)
  end
end

return tag_signals
