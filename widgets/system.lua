--- system.lua
-- Contains functions providing widgets with information about
-- the current state of the system.
---

local awful = require('awful')

local system = {}
local ram_script = os.getenv('HOME') .. '/.config/awesome/widgets/scripts/ram_usage'
local cpu_script = os.getenv('HOME') .. '/.config/awesome/widgets/scripts/cpu_usage'

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
return system
