require("full-border").setup()

require("eza-preview").setup()

require("yatline"):setup({
    theme = require("yatline-rosepine").setup("moon"),
    section_separator = { open = "", close = "" },
    part_separator = { open = "", close = "" },
    inverse_separator = { open = "", close = "" },
})
