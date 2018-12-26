-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local lain = require("lain")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys").tmux.add_rules_for_terminal({ rule = { name = "tmux"}})


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

-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        findme = cmd
        firstspace = cmd:find(" ")
        if firstspace then
            findme = cmd:sub(0, firstspace-1)
        end
        awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
    end
end

run_once({
    "compton --dbus",
    "unclutter -root",
    "light-locker",
    "dropbox",
})

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/blox/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
terminal_floating = "kitty -o initial_window_width=120c -o initial_window_height=32c -o remember_window_size=no"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    lain.layout.termfair,
    -- lain.layout.cascade,
    -- lain.layout.cascade.tile,
    lain.layout.centerwork,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.floating,
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol    = 1
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()


local battery  = require("widgets/battery")
local volume   = require("widgets/volume")
local diskfree = require("widgets/diskfree")
local redshift = require("widgets/redshift")

-- {{{ Wibar
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
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- tag management
local sharedtags = require("sharedtags")
local tags = sharedtags({
        {
            name = "1",
            icon = beautiful.tags_doc,
            layout = awful.layout.layouts[1]
        },
        {
            name = "2",
            icon = beautiful.tags_internet,
            layout = awful.layout.layouts[1]
        },
        {
            name = "3",
            icon = beautiful.tags_develop,
            layout = awful.layout.layouts[1]
        },
        {
            name = "4",
            icon = beautiful.tags_develop,
            layout = awful.layout.layouts[1]
        },
        {
            name = "5",
            icon = beautiful.tags_files,
            layout = awful.layout.layouts[1]
        },
        {
            name = "6",
            icon = beautiful.tags_files,
            layout = awful.layout.layouts[1]
        },
        {
            name = "7",
            icon = beautiful.tags_term,
            layout = awful.layout.layouts[1]
        },
        {
            name = "8",
            icon = beautiful.tags_term,
            layout = awful.layout.layouts[1]
        },
})

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
    -- Wallpaper
    set_wallpaper(s)

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
           -- mylauncher,
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
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

padding_enabled = true
-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    awful.key({ "Mod1",           }, "Tab", client_menu_toggle_fn
        {description = "client menu", group = "client"}),


    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "Return", function ()
                  awful.spawn(terminal_floating, {
                    floating  = true,
                    ontop = true,
                    titlebars_enabled = false,
                    tag       = mouse.screen.selected_tag,
                    placement = awful.placement.bottom_right,
                  })
              end,
              {description = "open a floating terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey },            "d",     function () awful.spawn("rofi -show drun") end,
              {description = "rofi", group = "launcher"}),
    awful.key({ modkey },            "c",     function () awful.spawn("networkmanager_dmenu") end,
              {description = "network connections", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),

    -- Brighntess Control
    awful.key({ }, "XF86MonBrightnessUp",
        function ()
            os.execute("brightnessctl s 1%+")
        end),
    awful.key({ }, "XF86MonBrightnessDown",
        function ()
            os.execute("brightnessctl s 1%-")
        end),

    -- Audio Control
    awful.key({ }, "XF86AudioRaiseVolume",
        function ()
            os.execute("pactl set-sink-volume 0 +5% && paplay $SOUND_THEME_FREEDESKTOP/share/sounds/freedesktop/stereo/audio-volume-change.oga")
        end),
    awful.key({ }, "XF86AudioLowerVolume",
        function ()
            os.execute("pactl set-sink-volume 0 -5% && paplay $SOUND_THEME_FREEDESKTOP/share/sounds/freedesktop/stereo/audio-volume-change.oga")
        end),
    awful.key({ }, "XF86AudioMute",
        function ()
            os.execute("pactl set-sink-mute 0 toggle && paplay $SOUND_THEME_FREEDESKTOP/share/sounds/freedesktop/stereo/audio-volume-change.oga")
        end),
    awful.key({ }, "XF86AudioMicMute",
        function ()
            os.execute("pactl set-source-mute 1 toggle && paplay $SOUND_THEME_FREEDESKTOP/share/sounds/freedesktop/stereo/audio-volume-change.oga")
        end),

    awful.key({ modkey },            ",",     function ()
            local tag = awful.screen.focused().selected_tag
            awful.screen.focus_relative(-1)
            local screen = awful.screen.focused()
            sharedtags.movetag(tag, screen)
        end,
        {description = "move focused tag to previous screen", group = "screen"}),

    awful.key({ modkey },            ".",     function ()
            local tag = awful.screen.focused().selected_tag
            awful.screen.focus_relative(1)
            local screen = awful.screen.focused()
            sharedtags.movetag(tag, screen)
        end,
        {description = "move focused tag to next screen", group = "screen"}),

    awful.key({ modkey },            "-",     function ()
            local selected_tag = awful.screen.focused().selected_tag
            selected_tag.gap = selected_tag.gap > 10 and selected_tag.gap - 10 or 0
        end,
        {description = "decrease gap", group = "layout"}),

    awful.key({ modkey, "Shift" },            "-",     function ()
            local selected_tag = awful.screen.focused().selected_tag
            selected_tag.gap = selected_tag.gap + 10
        end,
        {description = "increase gap", group = "layout"}),

    awful.key({ modkey, "Shift" },            "p",     function ()
            padding_enabled = not padding_enabled
        end,
        {description = "toggle padding", group = "layout"}),

    awful.key({ "Mod1", "Ctrl" },            "l",     function () awful.spawn("light-locker-command -l") end,
        {description = "lock workspace", group = "screen"}),
    awful.key({ "Mod1", "Ctrl" },            "a",     function () awful.spawn("keepass --auto-type") end),
    awful.key({                },        "Print",     function () awful.spawn("scrot 'Screenshot-%Y-%m-%d-%T_$wx$h.png' -e 'mv $f ~/Képek/'") end,
        {description = "take screenshot", group = "screen"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = tags[i]
                        if tag then
                           sharedtags.viewonly(tag, screen)
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = tags[i]
                      if tag then
                          sharedtags.viewtoggle(tag, screen)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = function(c) return not c.requests_no_titlebar end }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

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
        if width > max_width and padding_enabled then
            padding = math.floor((width - max_width) / (2 * client_factor))
        end
        screen.padding = gears.table.join(
            screen.padding,
            {
                left = padding,
                right = padding,
            }
        )
        screen.selected_tag.gap = math.floor(default_gaps / client_factor)
    end

    client.connect_signal("manage", function(c) adjust_gaps(c.screen) end)
    client.connect_signal("unmanage", function(c) adjust_gaps(c.screen) end)
    client.connect_signal("raised", function(c) adjust_gaps(c.screen) end)
    client.connect_signal("lowered", function(c) adjust_gaps(c.screen) end)

    awful.screen.connect_for_each_screen(function(s)
        s:connect_signal("tag::history::update", adjust_gaps)
    end)
end

-- {{{ Signals

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
-- }}}
