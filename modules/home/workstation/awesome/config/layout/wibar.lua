local awful      = require("awful")
local beautiful  = require("beautiful")
local gears      = require("gears")
local wibox      = require("wibox")

local clientmenu = require("layout.clientmenu")

local battery    = require("widgets/battery")
local volume     = require("widgets/volume")
local diskfree   = require("widgets/diskfree")
local redshift   = require("widgets/redshift")

-- {{{ Wibar
-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, clientmenu.toggle()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function widget_with_underline(args)
    local underline_size = args.underline_size or 1
    local color_selected = args.color_selected or beautiful.fg_focus
    local color_normal  = args.color_normal or beautiful.fg_normal

    local selected_cb = args.selected_callback or function(o)
        return false
    end

    local default_cb = function(widget, o, ...)
        local underline = widget:get_children_by_id("underline_role")[1]
        if underline then
            underline.color = args.selected_callback(o) and color_selected or color_normal
        end
    end
    return {
        create_callback = default_cb,
        update_callback = default_cb,
        {
            {
                {
                    {
                        {
                            id     = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        margins = 2,
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    fill_space = true,
                    layout = wibox.layout.fixed.horizontal,
                },
                id = 'underline_role',
                bottom  = underline_size,
                widget = wibox.container.margin,
            },
            left  = 4,
            right  = 4,
            widget = wibox.container.margin,
        },
        id     = 'background_role',
        widget = wibox.container.background,
    }
end

local sep = wibox.widget {
  left = 2,
  widget = wibox.container.margin,
}


awful.screen.connect_for_each_screen(function(s)
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        widget_template = beautiful.taglist_underline_size and
            widget_with_underline {
                selected_callback = function(t) return t.selected end,
                underline_size  = beautiful.taglist_underline_size
            }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = wibox.widget {
            max_widget_size = beautiful.tasklist_max_button_size,
            layout = wibox.layout.flex.horizontal,
        },
        widget_template = beautiful.tasklist_underline_size and
            widget_with_underline {
                selected_callback = function(c) return client.focus == c end,
                underline_size  = beautiful.tasklist_underline_size
            }
    }

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen = s
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
           -- mainmenu.launcher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            sep,
            redshift.widget,
            sep,
            volume.widget,
            sep,
            diskfree.widget,
            sep,
            battery.widget,
            wibox.widget.systray(),
            mytextclock,
            {
                s.mylayoutbox,
                margins  = 4,
                layout = wibox.container.margin,
            },
        },
    }
end)
