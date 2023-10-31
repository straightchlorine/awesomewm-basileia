--- mpd.lua
-- Provides simple textbox widget displaying the name of currently played song.
-- [slightly adjusted https://awesomewm.org/recipes/mpc/]
---

local mpc = require('utility.mpc')

--- Format song name by removing square brackets and trimming spaces.
--
-- Note: Naturally, if your you do not wish for such behaviour it is safe
-- to remove the function or simply to not call it within update_widget().
--
-- @tparam string filename of the song obtained via mpc
local function song_formatting(song_filename)
  local off_suffix = song_filename:gsub('.mp3', '')
  local off_brackets = off_suffix:gsub('%[.-]', '')
  return off_brackets:match('^%s*(.-)%s*$')
end

-- Create textbox widget
local mpd = require('wibox.widget').textbox()

-- Initialize default values
local state, title, artist, file = 'stop', '', '', ''

--- Update the caption of the mpd widget
--
-- If mpd is playing, current song is displayed.
local function update_widget()
  -- if you do not wish for the formatting provided by song_formatting(),
  -- just replace it with following line:
  -- local caption = tostring(file)
  local caption = song_formatting(tostring(file))

    if state ~= 'play' then
      mpd.text = ''
    else
      local play_text = '󰎉 ' .. caption
      mpd.text = play_text
    end

end

-- Connection with mpd
local connection
local timer = require('gears.timer')

--- Handle errors
local function error_handler(err)
  mpd:set_text('Error: ' .. tostring(err))
  -- Try a reconnect soon-ish
  timer.start_new(10, function()
    connection:send('ping')
  end)
end

-- localhost, 6600, no password
local host, port, pass = nil, nil, nil

--- Set up a connection via mpc.
--
-- By default first three nil parameters are:
--
-- host (localhost)
-- port (6600)
-- password (none)
--
-- If your configuration is different, you should change those values.
connection = mpc.new(host, port, pass, error_handler,
  'status', function(_, result)
    state = result.state
    pcall(update_widget)
  end,
  'currentsong', function(_, result)
    file = result.file
    pcall(update_widget)
  end)

return mpd
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
