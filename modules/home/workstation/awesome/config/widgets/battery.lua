local awful = require("awful")
local beautiful = require("beautiful")
local lain  = require("lain")
local wibox = require("wibox")

local lib   = require("widgets/lib")

local status = "N/A"
local tip = awful.tooltip({
    timer_function = function()
            return status
        end,
    })

local underline = wibox.container.margin()

local batstatus = lain.widget.bat({
    timeout = 5,
    settings = function()
        if type(bat_now.perc) ~= "number" then
            return ""
        end
        local markup = lain.util.markup
        local baticon = (function()
            if bat_now.status == "Charging" then
                if bat_now.perc > 95 then
                    return ""
                elseif bat_now.perc > 85 then
                    return ""
                elseif bat_now.perc > 70 then
                    return ""
                elseif bat_now.perc > 60 then
                    return ""
                elseif bat_now.perc > 50 then
                    return ""
                elseif bat_now.perc > 35 then
                    return ""
                elseif bat_now.perc > 15 then
                    return ""
                else
                    return markup.fg("red", "")
                end
            else
                if bat_now.perc > 95 then
                    return ""
                elseif bat_now.perc > 85 then
                    return ""
                elseif bat_now.perc > 75 then
                    return ""
                elseif bat_now.perc > 65 then
                    return ""
                elseif bat_now.perc > 55 then
                    return ""
                elseif bat_now.perc > 45 then
                    return ""
                elseif bat_now.perc > 35 then
                    return ""
                elseif bat_now.perc > 25 then
                    return ""
                elseif bat_now.perc > 15 then
                    return ""
                else
                    return markup.fg("red", "")
                end
            end
        end)()

        underline.color = lib.get_color_for_proggress(math.min(bat_now.perc, 50) / 50)
        widget:set_markup(bat_now.perc .. "%" .. markup.font("Material Design Icons 12", baticon))
        status = bat_now.perc .. "% -- " .. bat_now.time .. " (" .. bat_now.watt .. "W)"
    end
})
underline.widget = batstatus.widget
underline.bottom = beautiful.tasklist_underline_size
tip:add_to_object(batstatus.widget)


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
