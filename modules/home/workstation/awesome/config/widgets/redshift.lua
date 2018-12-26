local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")
local lain  = require("lain")
local markup = lain.util.markup


local redshift_text = wibox.widget {
    align  = "center",
    widget = wibox.widget.textbox,
}

local redshift_cb = wibox.widget {
    checked      = false,
    check_color  = beautiful.fg_normal .. "80",
    border_color = beautiful.fg_normal,
    border_width = 1,
    shape        = gears.shape.square,
    widget       = wibox.widget.checkbox
}

local redshift_widget = wibox.widget{
    {
        redshift_cb,
        redshift_text,
        layout = wibox.layout.stack,
    },
    top    = 6,
    bottom = 4,
    left   = 2,
    right  = 2,
    widget = wibox.layout.margin
}

lain.widget.contrib.redshift:attach(
    redshift_widget,
    function (active)
        if active then
            redshift_text:set_markup(markup(beautiful.bg_normal, ""))
        else
            redshift_text:set_markup(markup(beautiful.fg_normal, ""))
        end
        redshift_cb.checked = active
    end
)

return {
    widget = redshift_widget
}
