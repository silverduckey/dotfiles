require("relative-motions"):setup({
    show_numbers = "relative_absolute",
    show_motion = true,
    enter_mode = "first",
})

require("eza-preview"):setup({
    git_status = true,
})

require("full-border"):setup()

require("yatline"):setup({
    theme = require("yatline-rosepine").setup("moon"),
    section_separator = { open = "", close = "" },
    part_separator = { open = "", close = "" },
    inverse_separator = { open = "", close = "" },
})
