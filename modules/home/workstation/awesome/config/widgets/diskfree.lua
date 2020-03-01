local awful = require("awful")
local beautiful = require("beautiful")
local lain  = require("lain")
local wibox = require("wibox")

local lib   = require("widgets/lib")


local underline = wibox.container.margin()

local batstatus = lain.widget.fs({
    timeout = 61,
    settings = function()
        local root_avail_p = 100 - fs_now["/"].percentage
        local root_avail_gb = fs_now["/"].free
        local home_avail_p = 100 - fs_now["/home"].percentage
        local home_avail_gb = fs_now["/home"].free

        local markup = lain.util.markup

        local color = lib.get_color_for_proggress(math.min(home_avail_gb, root_avail_gb, 50) / 50)
        underline.color = color
        widget:set_markup(
            markup.fg.color(color, "/") .. ": " .. root_avail_p .. "% | " ..
            markup.fg.color(color, "/home") .. ": " .. home_avail_p .. "%" ..
            markup.font("Material Design Icons 12", "")
        )
    end
})
underline.widget = batstatus.widget
underline.bottom = beautiful.tasklist_underline_size


return {
    widget = wibox.widget {
        {
            underline,
            left = 4,
            right = 4,
            widget = wibox.container.margin,
        },
        widget = wibox.container.background
    }
}
