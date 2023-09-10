return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local function source()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                    return {
                        added = gitsigns.added,
                        modified = gitsigns.changed,
                        removed = gitsigns.removed
                    }
                end
            end

            require("lualine").setup({
                options = {
                    component_separators = { left = "|", right = "|" },
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_b = {
                        {
                            "b:gitsigns_head",
                            icon = ""
                        },
                        {
                            "diff",
                            source = source
                        },
                        "diagnostics",
                    },
                    lualine_c = {
                        {
                            "filename",
                            path = 3,
                        },
                    },
                },
                extensions = { "lazy", "nvim-dap-ui", "toggleterm" },
            })
        end,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                messages = {
                    view_history = "notify",
                    view_search = false,
                },
                commands = {
                    history = {
                        view = "popup",
                    },
                },
                presets = {
                    command_palette = true,
                    long_message_to_split = true,
                },
            })

            require("notify").setup({
                stages = "slide",
                timeout = 500,
            })
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup({
                key_labels = {
                    ["<Space>"] = "SPC",
                    ["<CR>"] = "RET",
                    ["<Tab>"] = "TAB",
                },
            })
        end,
    }
}
