--- integration.lua
-- Methods providing eww widgets integration to the environment.
---

local files = require('utility.files')
local env = require('utility.environment')

--- Generate JSON image of every defined tag.
local function init_tag_cache()
  local content = require('utility.eww.overview').tags()
  local file = io.open(env.eww.tag_overview, 'w')

  if file then
    file:write(content)
    file:close()
  end
end

--- Create required files, which store active tag for every screen.
local function init_active_tag_cache()
  for i = 1, screen.count() do
    local active_tag = tostring(i) .. '-active-tag'
    local file = io.open(env.eww[active_tag], 'w')

    if file then
      file:write(tostring(1))
      file:close()
    end
  end
end

--- Initialize cache folder for awesomewm.
--
-- By default folder is created in $HOME/.cache/awesomewm and contains full tag
-- overview, and active tag for every connected screen.
--
-- Helps to avoid any problems with eww receiving incorrect data, or failing to
-- find required files.
local function init_cache()
  -- checks if the $HOME/.cache/awesomewm directory exists
  if not files.isdir(os.getenv('HOME') .. '.cache/awesomewm') then
    os.execute('mkdir -p $HOME/.cache/awesomewm')
  end
  init_active_tag_cache()
  init_tag_cache()
end

--- Log required data about state of every tag into JSON file.
--
-- File is located in $HOME/.cache/awesomewm/tag-overview and contains overview
-- of every tag i.e.:
--  display
--    tag id
--    number of clients assigned to the tag
local function log_overview()
  files.log(env.eww.tag_overview, require('utility.eww.overview').tags())
end

--- Log active tag for every connected screen.
--
-- File is located in $HOME/.cache/awesomewm/<x>-active-tag, where <x> is the id
-- of screen within awesomewm (starting from 1).
local function log_active(tag)
  local screen_id = tostring(tag.screen.index)
  local path = env.eww[tostring(screen_id) .. '-active-tag']
  files.log(path, tag.name)
end

--- Log state of tags every time tag is selected.
--
-- Calls both log_overview() and log_active() each time tag is selected in order
-- to mantain up to date information for eww widgets.
local function tag_selection(t)
  t:connect_signal('property::selected', function(tag)
    log_active(tag)
    log_overview()
  end)
end

--- Log state of tags every time new client is created (window open).
--
-- Calls both log_overview() and log_active() each time tag is selected in order
-- to mantain up to date information for eww widgets.
local function tag_active(t)
  t:connect_signal('tagged', function(tag)
    log_active(tag)
    log_overview()
  end)
end

--- Kill eww processes with restart.
local function kill()
  if env.eww.enable_integration then
    awesome.connect_signal('exit', function ()
      os.execute('pkill -9 eww')
    end)
  end
end

--- Connect required signals to each tag during initial tag definition.
local function signals()
  screen.connect_signal('request::desktop_decoration', function(s)
    for _, tag in ipairs(s.tags) do
      tag_selection(tag)
      tag_active(tag)
    end
  end)

  kill()
end

local integration = {}

--- Set up and run eww widgets.
--
-- Function flow:
--  1. Create (if does not exist) cache folder in $HOME/.cache/awesomewm.
--  2. Initializes files for both active tag and overview of the whole tag array.
--  3. Connects required signals in order to keep the logs up to date.
--  4. Opens eww widgets after everything is done.
function integration.setup()
  if env.eww.enable_integration then
    init_cache()
    signals()
    require('awful').spawn.with_shell(env.scripts.run_eww)
  end
end

return integration
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
