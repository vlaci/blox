local beautiful = require("beautiful")

local theme = require("theme")

beautiful.init(theme)

require("awful.autofocus")
require("awful.hotkeys_popup.keys").tmux.add_rules_for_terminal({ rule = { name = "tmux"}})

require("module.autostart")
require("module.bindings")
require("module.layouts")
require("module.notifications")
require("module.rules")
require("module.wallpaper")
require("layout.client")
require("layout.wibar")
