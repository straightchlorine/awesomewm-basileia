--- bar_management.lua
-- File contains functions, which manage wibar widgets on multihead setup.
---

local bars = require('widgets.bars')

--- Switch bars between displays.
--
-- @param screen_a screen with the main_bar
-- @param screen_b screen meant to have main_bar after swap
local function switch (screen_a, screen_b)
  -- easiest way to make sure that taglists work properly
  -- is to simply initialize them again
  screen_a.bar:remove()
  screen_b.bar:remove()
  bars.main_bar(screen_b, 'Mod4')
  bars.side_bar(screen_a, 'Mod4')
end

local awful = require('awful')

--- Switch bars in base state.
--
-- Base state, that is when main_bar is on the primary display
-- and side_bar is on the secondary display.
local function switch_bars ()
  switch(screen[1], screen[2])
  return true
end

--- Restore bars to base state
--
-- Switching the bars back, i.e. moving main_bar from the secondary display
-- to the primary one, and vice versa.
local function restore_bars ()
  switch(screen[2], screen[1])
  return false
end

local management = {}

--- Boolean keeping track of the current state.
-- If the bars have been switched, i.e. are not in base state, this variable
-- should be true.
local switched = false

--- Toggles screens to which bars are attached.
function management.toggle_switch_bars ()

  if not switched then
    switched = switch_bars()
  else
    switched = restore_bars()
  end

end

--- Checks if the given screen's orientation is vertical.
--
-- @param screen screen object being verified
-- @return true if orientation of given screen is vertical
function management.is_vertical (screen)
  local screen_geometry = screen.geometry
  return screen_geometry.height > screen_geometry.width
end

return management
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
