local beautiful = require("beautiful")
local naughty   = require("naughty")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}


local tags = require("configuration.tags")

for _, tag in ipairs(tags) do
    local notification = nil
    tag:connect_signal("property::layout", function(t)
        naughty.destroy(notification, naughty.notificationClosedReason.expired)
        notification = naughty.notify({
            text = "New layout: " .. tag.layout.name,
            position = "top_middle",
            font = beautiful.font .. " 12",
            icon = beautiful["layout_" .. tag.layout.name],
            margin = 10,
            timeout = 2,
        })
    end)
end

