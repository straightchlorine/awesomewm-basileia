local awful = require('awful')
local gears = require('gears')

local dpi = require('beautiful.xresources').apply_dpi

local target = { client = client, mouse = mouse }
local resize = { amount = dpi(10), factor = 0.05 }

local naughty = require('naughty')

function notifyDebug (text)
    naughty.notify({ preset = naughty.config.presets.normal,
                     title = "~technical notification~",
                     text = text})
end

local client = {}

function  client.resize(c, direction)
  if c and c.floating or awful.layout.get(target.mouse.screen) == awful.layout.suit.floating then
    if direction == 'up' then
      c:relative_move(0, 0, 0, -resize.amount)
    elseif direction == 'right' then
      c:relative_move(0, 0, resize.amount, 0)
    elseif direction == 'down' then
      c:relative_move(0, 0, 0, resize.amount)
    elseif direction == 'left' then
      c:relative_move(0, 0, -resize.amount, 0)
    end
  elseif awful.layout.get(target.mouse.screen) ~= awful.layout.suit.floating then
    if direction == 'up' then
      awful.client.incwfact(-resize.factor)
    elseif direction == 'right' then
      awful.tag.incmwfact(resize.factor)
    elseif direction == 'down' then
      awful.client.incwfact(resize.factor)
    elseif direction == 'left' then
      awful.tag.incmwfact(-resize.factor)
    end
  end
end

function client.center(c)
    return gears.timer.delayed_call(function ()
        awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
    end)
end

return client
