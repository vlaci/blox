local beautiful = require("beautiful")
local color = require("gears.color")

local function get_color_for_progress(fact)
    local u_r, u_g, u_b, u_a = color.parse_color(beautiful.fg_urgent)
    local n_r, n_g, n_b, n_a = color.parse_color(beautiful.fg_normal)

    return string.format(
        "#%02x%02x%02x",
        255 * (u_r + fact * (n_r - u_r)),
        255 * (u_g + fact * (n_g - u_g)),
        255 * (u_b + fact * (n_b - u_b))
    )
end

return {
 get_color_for_proggress = get_color_for_progress
}
