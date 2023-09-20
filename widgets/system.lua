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
function system.root()

  local root = awful.widget.watch([[df -h /]], 60, function(widget, stdout)
    for line in stdout:gmatch('[%d]+%%+') do
      widget:set_text('  ' .. line)
    end
    widget.forced_width = 80
  end)

  return root
end

-- Return awful.widget object displaying information received through the
-- network interface.
function system.net_rx()

  local rx = awful.widget.watch(net_script .. ' --rx', 1, function (widget, stdout)
    widget:set_text(' ' .. stdout)
    widget.forced_width = 120
  end)

  return rx
end

-- Return awful.widget object displaying information sent through the
-- network interface.
function system.net_tx()

  local tx = awful.widget.watch(net_script .. ' --tx', 1, function (widget, stdout)
    widget:set_text(' ' .. stdout)
    widget.forced_width = 120
  end)

  return tx
end

return system
