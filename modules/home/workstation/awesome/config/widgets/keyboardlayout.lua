local awful      = require("awful")
local beautiful  = require("beautiful")
local wibox      = require("wibox")

local lain = require("lain")

local awpwkb = require("awpwkb")
local kb     = awpwkb.get() or awpwkb.init()

local menu_layouts = {}

for i, l in pairs(kb:get_layouts()) do
   menu_layouts[i] = { l.name, function () kb:set_layout(l.name) end }
end

local kbmenu = awful.menu({ items = menu_layouts })

local function create_widget(current_layout, inner_widget)
    local widget = wibox.widget {
        {
            {
                {
                    widget = inner_widget(),
                    align = "center",
                    markup = lain.util.markup.font("monospace", current_layout and current_layout.name or "  "),
                    id = "kb_txt",
                },
                margins = 1,
                color = beautiful.fg_normal,
                layout = wibox.container.margin,
            },
            top    = 6,
            bottom = 4,
            left   = 2,
            right  = 2,
            widget = wibox.container.margin
        },
        direction = "north",
        layout = wibox.container.rotate
    }
    widget:buttons(
       awful.util.table.join(
          awful.button({ }, 1, function() kb:set_next_layout() end),
          awful.button({ }, 2, function() kb:set_prev_layout() end),
          awful.button({ }, 3, function() kbmenu:toggle() end)
       )
    )
    return widget
end

local function widget_for_client(c)
    local l = kb:find_layout_by_idx(c.awpwkb_layout) or kb:get_current_layout()
    local widget = create_widget(l, wibox.widget.textbox)
    c.client_kb_layout = widget:get_children_by_id("kb_txt")[1]
    return widget
end

local global_widget = create_widget(kb:get_current_layout(), awful.widget.keyboardlayout)
-- change markup on layout change
kb.on_layout_change = function (layout)
    --global_widget:get_children_by_id("kb_txt")[1].markup = lain.util.markup.font("monospace", layout.name)
end

kb:connect_signal("on_layout_change", function(kb, layout)
    local c = client.focus
    if c == nil or c.client_kb_layout == nil then
        return
    end
    if not c.requests_no_titlebar then
        local l = kb:find_layout_by_idx(c.awpwkb_layout) or kb:get_current_layout()
        c.client_kb_layout.markup = lain.util.markup.font("monospace", l and l.name or "  ")
    end
end)
return {
  widget = global_widget,
  widget_for_client = widget_for_client,
}
