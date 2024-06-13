--- environment.lua
-- Contains important hardcoded data, such as paths and important variables.
---

local gears = require("gears")

--- Object contains all preset paths and some variables, related to its execution
local env = {}

--- By default 'Mod4' i.e. windows key or 'Command'
env.modkey = "Mod4"

--- Important data for the eww integration.
env.eww = {}

--- True, if eww integration is desired.
env.eww.enable_integration = false

local logs = os.getenv("HOME") .. "/.cache/awesomewm/"
for i = 1, screen.count() do
	local name = tostring(i) .. "-active-tag"
	env.eww[name] = logs .. name
end

env.eww.tag_overview = logs .. "tag-overview"

local configuration_scripts = gears.filesystem.get_configuration_dir() .. "configuration/scripts/"

--- Contains paths to scripts.
env.scripts = {}

--- Path to the autorun script.
env.scripts.autorun = configuration_scripts .. "autorun"

--- Path to run-eww script.
env.scripts.run_eww = configuration_scripts .. "run-eww"

-- Path to the screen responsible for display rotation.
env.scripts.rotation = configuration_scripts .. "toggle_rotation " .. tostring(env.eww)

local widget_scripts = gears.filesystem.get_configuration_dir() .. "widgets/scripts/"

--- Contains paths to scripts used by system widgets.
-- (widgets/system.lua)
env.scripts.widgets = {}

--- Path to cpu-usage script.
env.scripts.widgets.cpu = widget_scripts .. "cpu-usage"

--- Path to ram-usage script.
env.scripts.widgets.ram = widget_scripts .. "ram-usage"

--- Path to network-sample script.
env.scripts.widgets.net_rx = widget_scripts .. "network-sample --rx"

--- Path to network-sample script.
env.scripts.widgets.net_tx = widget_scripts .. "network-sample --tx"

--- Contains paths and data for weather widget.
env.scripts.widgets.weather = {}

--- Openweather API key.
env.scripts.widgets.weather.api = "openweather api key"

--- Openweather city id.
env.scripts.widgets.weather.city = "openweather city id"

--- Both arguments concatenated.
env.scripts.widgets.weather.api_city = env.scripts.widgets.weather.api .. " " .. env.scripts.widgets.weather.city

--- Path to weather script, with API and city id passed as arguments.
env.scripts.widgets.weather.script = widget_scripts .. "weather --status " .. env.scripts.widgets.weather.api_city

--- Paths related to rofi.
env.rofi = {}

--- Path to script launching rofi launcher.
env.rofi.launcher = os.getenv("HOME") .. "/.config/rofi/launchers/type-4/launcher.sh"

-- Path where the rofi applets are.
env.rofi.applets = os.getenv("HOME") .. "/.config/rofi/applets/bin/"

--- Path to rofi applet providing screenshot tool.
env.rofi.screenshot_utility = env.rofi.applets .. "screenshot.sh"

return env
-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
