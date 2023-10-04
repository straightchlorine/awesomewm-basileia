--- system.lua
-- Contains functions providing widgets with information about
-- the current state of the system.
---

local awful = require('awful')

local system = {}

-- path to the cpu_usage script
local cpu_script = os.getenv('HOME') .. '/.config/awesome/widgets/scripts/cpu-usage'
-- path to the ram_usage script
local ram_script = os.getenv('HOME') .. '/.config/awesome/widgets/scripts/ram-usage'
-- path to the network-sample script
local net_script = os.getenv('HOME') .. '/.config/awesome/widgets/scripts/network-sample'

--- Return awful.widget object containing usage of cpu.
--
-- @return awful.widget
function system.cpu()

  local cpu = awful.widget.watch(cpu_script, 1, function (widget, stdout)
    for line in stdout:gmatch('%d+%.%d+') do
      widget:set_text('  ' .. line .. '%')
    end
    widget.forced_width = 80
  end)

  return cpu
end

--- Return awful.widget object containing usage of ram.
--
-- @return awful.widget
function system.ram()

  local ram = awful.widget.watch(ram_script, 1, function (widget, stdout)
    for line in stdout:gmatch('%d+%.%d+') do
      widget:set_text('  ' .. line .. '%')
    end
    widget.forced_width = 80
  end)

  return ram
end

--- Return awful.widget object displaying space occupied on the root partition.
--
-- @return awful.widget
function system.root()

  local root = awful.widget.watch([[df -h /]], 60, function(widget, stdout)
    for line in stdout:gmatch('[%d]+%%+') do
      widget:set_text('  ' .. line)
    end
    widget.forced_width = 80
  end)

  return root
end

--- Return awful.widget object displaying state of the battery.
--
-- Note that, for the sake of simplicity acpi is used instead of basic 
-- /sys/class/power_supply directory
--
-- @return awful.widget

local battery = require('widgets.battery')
function system.battery()

  local bat = awful.widget.watch('acpi -b', 1, function (widget, stdout)
    for status, capacity, hours, minuts, seconds in stdout:gmatch('Battery 0: (.+), (%d+)%%, (%d%d):(%d%d):(%d%d)') do
        widget:set_text(battery.icon(tonumber(capacity), status) .. '  ' .. capacity .. '%')
        widget.forced_width = 60
    end
  end)

  return bat
end

--- Return awful.widget object displaying information received through the
--- network interface.
--
-- @return awful.widget
function system.net_rx()

  local rx = awful.widget.watch(net_script .. ' --rx', 1, function (widget, stdout)
    widget:set_text(' ' .. stdout)
    widget.forced_width = 120
  end)

  return rx
end

--- Return awful.widget object displaying information sent through the
--- network interface.
--
-- @return awful.widget
function system.net_tx()

  local tx = awful.widget.watch(net_script .. ' --tx', 1, function (widget, stdout)
    widget:set_text(' ' .. stdout)
    widget.forced_width = 120
  end)

  return tx
end

local wibox = require('wibox')

--- Returns awful.widget object displaying information both received and
--- transmitted through network interface.
--
-- @return awful.widget
function system.network()
  return {
    system.net_rx(),
    system.net_tx(),
    layout = wibox.layout.fixed.horizontal
  }
end

--- Groups widgets presenting disk, ram and cpu usage.
--
-- @return awful.widget
function system.info()
  return {
    system.root(),
    system.ram(),
    system.cpu(),
    layout = wibox.layout.fixed.horizontal
  }
end

--- Groups network, disk, ram and cpu widgets into single one.
--
-- @return awful.widget
function system.status()
  return {
    system.network(),
    system.info(),
    system.battery(),
    layout = wibox.layout.align.horizontal
  }
end

return system
