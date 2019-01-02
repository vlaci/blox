local awful = require("awful")
local lain = require("lain")
local wibox     = require("wibox")
local naughty = require("naughty")


local tooltip = "N/A"

local volume = lain.widget.pulse({
    settings = function()
        local markup = lain.util.markup
        local icon = "N/A"
        local vol = tonumber(volume_now.left)
        if volume_now.muted == "yes" then
            icon = ""
        elseif vol > 100 then
            icon = markup.fg("orange", "")
        elseif vol > 67 then
            icon = ""
        elseif vol > 33 then
            icon = ""
        else
            icon = ""
        end
        widget:set_markup(markup.font("Material Design Icons 12", icon))

        tooltip = volume_now.left
    end
})

local tip = awful.tooltip({
    timer_function = function()
            return tooltip
        end,
    })
tip:add_to_object(volume.widget)

volume.widget:buttons(awful.util.table.join(
    awful.button({}, 1, function() -- left click
        awful.spawn("pavucontrol")
    end),
    awful.button({}, 2, function() -- middle click
        awful.spawn(string.format("pactl set-sink-volume %d 100%%", volume.device))
        volume.update()
    end),
    awful.button({}, 3, function() -- right click
        awful.spawn(string.format("pactl set-sink-mute %d toggle", volume.device))
        volume.update()
    end),
    awful.button({}, 4, function() -- scroll up
        awful.spawn(string.format("pactl set-sink-volume %d +1%%", volume.device))
        volume.update()
    end),
    awful.button({}, 5, function() -- scroll down
        awful.spawn(string.format("pactl set-sink-volume %d -1%%", volume.device))
        volume.update()
    end)
))

local margin = wibox.container.margin(volume.widget, 4, 4)
margin:set_top(6)
margin:set_bottom(6)

return {
    widget = wibox.container.background(margin),
}
