local wezterm = {
    color_scheme = "Catppuccin Mocha",
    font = require("wezterm").font_with_fallback({
        "FiraCode Nerd Font Mono",
        "Noto Color Emoji",
    }),
    enable_tab_bar = false,
}
return wezterm
