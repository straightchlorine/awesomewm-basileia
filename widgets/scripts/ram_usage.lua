#!/bin/lua
--- ram_usage.lua
-- Script calculates percentage of ram memory currently used, 
-- based on /proc/meminfo.
---

--- Get % of ram used.
--
-- @return string containing the percentage (without % sign)
local function get_ram_usage()
  -- open /proc/meminfo file
  local meminfo = assert(io.open('/proc/meminfo', 'r'))

  -- fill total and available variables with total memory and available memory
  local total, available = nil, nil
  for line in meminfo:lines() do
    local key, value = string.match(line, '^(%a+):%s+(%d+)')
    if total == nil or available == nil then
      if key == 'MemTotal' then
        total = tonumber(value)
      elseif key == 'MemAvailable' then
        available = tonumber(value)
      end
    end
  end

  meminfo:close()

  -- calculate the usage
  local in_use = total - available
  local ram_usage = (in_use / total) * 100

  return string.format("%.2f", ram_usage)
end

print(get_ram_usage())
