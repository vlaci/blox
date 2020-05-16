local awful     = require("awful")
local beautiful = require("beautiful")
local gears     = require("gears")


local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s)
        awful.spawn.with_shell([[dbus-send \
            --system \
            --print-reply \
            --dest=org.freedesktop.Accounts \
            /org/freedesktop/Accounts/User$(id -u) \
            org.freedesktop.DBus.Properties.Set \
            string:org.freedesktop.DisplayManager.AccountsService \
            string:BackgroundFile \
            "variant:string:$(realpath ']] .. wallpaper .. [[')"]])
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)
end)
