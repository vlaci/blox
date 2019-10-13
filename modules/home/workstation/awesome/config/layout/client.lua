local awful     = require("awful")
local beautiful = require("beautiful")
local gears     = require("gears")
local wibox     = require("wibox")

local config = require("configuration.client")

do
    local default_gaps = beautiful.useless_gap
    local max_width = 1920
    beautiful.maximized_honor_padding = false

    local adjust_gaps = function(screen)
        local clients = #screen.tiled_clients
        local width = screen.geometry.width

        if screen.selected_tag == nil or clients == 0 then
            return
        end
        local client_factor = 1 + 3 * (clients - 1)

        local padding = 0
        if width > max_width and config.enable_padding then
            padding = math.floor((width - max_width) / (2 * client_factor))
        end
        screen.padding = gears.table.join(
            screen.padding,
            {
                left = padding,
                right = padding,
            }
        )

        local gap = 0
        if config.enable_padding then
            gap = math.floor(default_gaps / client_factor)
        end
        screen.selected_tag.gap = gap
    end

    client.connect_signal("manage", function(c) adjust_gaps(c.screen) end)
    client.connect_signal("unmanage", function(c) adjust_gaps(c.screen) end)
    client.connect_signal("raised", function(c) adjust_gaps(c.screen) end)
    client.connect_signal("lowered", function(c) adjust_gaps(c.screen) end)

    awful.screen.connect_for_each_screen(function(s)
        s:connect_signal("tag::history::update", adjust_gaps)
    end)
end

local function adjust_shape(c)
    if c.maximized or c.maximized_vertical or c.maximized_horizontal then
        c.shape = gears.shape.rectangle
    else
        c.shape = function(cr,w,h)
            gears.shape.rounded_rect(cr, w, h, 8)
        end
    end
end

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
    adjust_shape(c)
end)

client.connect_signal("request::geometry", adjust_shape)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = 19}) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
