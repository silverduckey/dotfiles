---------------------------
-- Default awesome theme --
---------------------------

local theme_assets          = require("beautiful.theme_assets")

local config_path           = require("gears.filesystem").get_configuration_dir()
local theme                 = {}

theme.font                  = "Ubuntu Nerd Font 10"

col_gray1                   = "#1e1e2e"
col_gray2                   = "#1e1e2e"
col_gray3                   = "#cdd6f4"
col_gray4                   = "#1e1e2e"
col_blue                    = "#89dceb"

theme.bg_normal             = col_gray1
theme.bg_focus              = col_blue
theme.bg_systray            = theme.bg_normal

theme.fg_normal             = col_gray3
theme.fg_focus              = col_gray4

theme.useless_gap           = 2
theme.gap_single_client     = false
theme.border_width          = 1
theme.border_normal         = col_gray2
theme.border_focus          = col_blue

local taglist_square_size   = 4
theme.taglist_squares_sel   = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

theme.layout_fairh          = config_path .. "theme/layouts/fairhw.png"
theme.layout_fairv          = config_path .. "theme/layouts/fairvw.png"
theme.layout_floating       = config_path .. "theme/layouts/floatingw.png"
theme.layout_magnifier      = config_path .. "theme/layouts/magnifierw.png"
theme.layout_max            = config_path .. "theme/layouts/maxw.png"
theme.layout_fullscreen     = config_path .. "theme/layouts/fullscreenw.png"
theme.layout_tilebottom     = config_path .. "theme/layouts/tilebottomw.png"
theme.layout_tileleft       = config_path .. "theme/layouts/tileleftw.png"
theme.layout_tile           = config_path .. "theme/layouts/tilew.png"
theme.layout_tiletop        = config_path .. "theme/layouts/tiletopw.png"
theme.layout_spiral         = config_path .. "theme/layouts/spiralw.png"
theme.layout_dwindle        = config_path .. "theme/layouts/dwindlew.png"
theme.layout_cornernw       = config_path .. "theme/layouts/cornernww.png"
theme.layout_cornerne       = config_path .. "theme/layouts/cornernew.png"
theme.layout_cornersw       = config_path .. "theme/layouts/cornersww.png"
theme.layout_cornerse       = config_path .. "theme/layouts/cornersew.png"

theme.icon_theme            = nil

return theme
