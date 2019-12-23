local beautiful  = require("beautiful")
local sharedtags = require("sharedtags")

local layouts    = require("configuration.layouts")


local tags = sharedtags({
    {
        name = "1",
        icon = beautiful.tags_doc,
        layout = layouts[1]
    },
    {
        name = "2",
        icon = beautiful.tags_internet,
        layout = layouts[1]
    },
    {
        name = "3",
        icon = beautiful.tags_develop,
        layout = layouts[1]
    },
    {
        name = "4",
        icon = beautiful.tags_develop,
        layout = layouts[1]
    },
    {
        name = "5",
        icon = beautiful.tags_files,
        layout = layouts[1]
    },
    {
        name = "6",
        icon = beautiful.tags_files,
        layout = layouts[1]
    },
    {
        name = "7",
        icon = beautiful.tags_term,
        layout = layouts[1]
    },
    {
        name = "8",
        icon = beautiful.tags_term,
        layout = layouts[1]
    },
    {
        name = "9",
        icon = beautiful.tags_term,
        layout = layouts[1]
    },
})

return tags
