#!/bin/lua
--- cpu_usage.lua
-- Script calculates approximate cpu usage(%) within 1 second, using /proc/stat file.
---

--- Parse first line from /proc/stat.
--
-- @param first line of the /proc/stat file.
-- @return array of variables extracted from the first line of /proc/stat.
local function parse_proc_stat(cpu_summary_line)
  local user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice =
    string.match(cpu_summary_line, 'cpu  (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+) (%d+)')

  local activity = {}
  activity.user = tonumber(user)
  activity.nice = tonumber(nice)
  activity.system = tonumber(system)
  activity.idle = tonumber(idle)
  activity.iowait = tonumber(iowait)
  activity.irq = tonumber(irq)
  activity.softirq = tonumber(softirq)
  activity.steal = tonumber(steal)
  activity.guest = tonumber(guest)
  activity.guest_nice = tonumber(guest_nice)
  return activity
end

--- Read first line from /proc/stat file and parse it into variables.
--
-- @return array of variables extracted from the first line of /proc/stat
local function read_proc_stat()
  -- read first line from /proc/stat system file
  local proc_stat = assert(io.open('/proc/stat', 'r'))
  local cpu = proc_stat:read()
  proc_stat:close()

  return parse_proc_stat(cpu)
end

--- Calculate both total use and idle activity.
--
-- @param array of cpu activity
-- @return array of total activity and idle time
local function calculate_usage(activity)
  local total = 0
  for _, value in pairs(activity) do
    total = total + value
  end

  local cpu_activity = {}
  cpu_activity.total = total
  cpu_activity.idle = activity.idle

  return cpu_activity
end

--- Get % of cpu used.
--
-- @return string containing the percentage (without % sign)
local function get_cpu_usage()
  -- read cpu usage within one second
  local pre_activity = read_proc_stat()
  os.execute('sleep 1')
  local post_activity = read_proc_stat()

  -- calculate the differences
  local pre_usage = calculate_usage(pre_activity)
  local post_usage = calculate_usage(post_activity)

  local total = post_usage.total - pre_usage.total
  local idle = post_usage.idle - pre_usage.idle

  -- convert activity into percentage
  local cpu_usage = (total - idle) / total * 100

  return string.format('%.2f', cpu_usage)
end

print(get_cpu_usage())
