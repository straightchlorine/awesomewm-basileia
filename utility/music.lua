--- music.lua
-- Interacting with mpd via mpc.
---

local music = {}

local awful = require('awful')
local env = require('utility.environment')

--- When 'mpd_status' is emitted, write status to cache.
awesome.connect_signal('mpd_status', function ()
  local command = [[mpc status | rg 'playing' > ]] .. env.cache.mpd_status
  awful.spawn.easy_async_with_shell(command)
end )

--- When 'mpd_current' is emitted, current track is written to chache.
awesome.connect_signal('mpd_current', function ()
  local command = [[ mpc current --wait | sed 's/\[.*// ' > ]] .. env.cache.mpd_current
  awful.spawn.easy_async_with_shell(command)
end)

--
-- If the caught command is empty, that means
-- it is not playing thus paused.
-- @return true when playing
local function status ()
  local command = [[mpc status | rg 'playing' > ]] .. env.cache.mpdstatus

  awful.spawn.easy_async_with_shell(command, function()
    awful.spawn.easy_async_with_shell('cat' .. env.mpd, function(out)
      if out == '' then
        awesome.emit_signal('mpd_status', false)
      else
        awesome.emit_signal('mpd_status', out)
      end
    end)
  end)
end

--- Current track name.
-- Probes for the name of the track, removes [video-id].mp3
-- from yt-dl and gets rid of newline.
-- @return name of the currently played track
local function track_name ()
  local command = [[mpc current | sed 's/\[.*// ']]
  local tty = assert(io.popen(command, 'r'))
  local output = assert(tty:read('*a'))
  output = string.gsub(output, '\n', '')
  return output
end

local naughty = require('naughty')

--- Notifies about currently played song.
-- If mpd is playing, it sends a notification via
-- naughty module with title of the song
function music.notify ()
  if status() then
    naughty.notification {
      urgency = 'low',
      title = '  Playing...',
      text = track_name(),
      position = 'top_left',
    }
  end
end

return music
