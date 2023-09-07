return {
    {
        "nyoom-engineering/oxocarbon.nvim",
        priority = 1000,
        config = function()
            api.nvim_create_user_command("Oxocarbon", function()
                vim.cmd.colorscheme("oxocarbon")
            end, {})
        end
    },

    {
        "rose-pine/neovim",
        priority = 1000,
        name = "rose-pine",
        config = function()
            api.nvim_create_user_command("RosePine", function()
                vim.cmd.colorscheme("rose-pine")
            end, {})
        end
    },

    {
        "arcticicestudio/nord-vim",
        priority = 1000,
        config = function()
            g.nord_uniform_diff_background = 1
            g.nord_italic = 1
            g.nord_italic_comments = 1
            g.nord_underline = 1

            api.nvim_create_user_command("Nord", function()
                vim.cmd.colorscheme("nord")
            end, {})

            vim.cmd("Nord")
        end,
    },
}
