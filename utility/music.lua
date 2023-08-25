--- music.lua

local music = {}

--- Retruns the state of mpd.
-- If the caught command is empty, that means
-- it is not playing thus paused.
-- @return true when playing
local function status ()
  local command = [[mpc status | rg 'playing']]
  local tty = assert(io.popen(command, 'r'))
  local output = assert(tty:read('*a'))
  tty:close()
 
  if output == '' then
    return false
  else
    return true
  end
end

local debug = require('utility.deubg')

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
