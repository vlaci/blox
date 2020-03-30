local editor = os.getenv("EDITOR") or "nvim"

return {
    autostart = {
        "flameshot",
        "compton --dbus",
        "unclutter -root",
        "light-locker",
        "dropbox",
    },
    terminal = "kitty",
    terminal_floating = "kitty -o initial_window_width=120c -o initial_window_height=32c -o remember_window_size=no",
    editor = "kitty -e " .. editor
}
