return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local alpha = require("alpha")
            local startify = require("alpha.themes.startify")
            local fortune = require("alpha.fortune")

            startify.section.header.val = fortune()

            startify.section.top_buttons.val = {
                startify.button("n", "  New file", "<CMD>ene <BAR> startinsert <CR>"),
                startify.button(".", "  File explorer", "<CMD>Vifm<CR>"),
            }

            startify.section.bottom_buttons.val = {
                startify.button("q", "  Quit", "<CMD>qa<CR>"),
            }

            alpha.setup(startify.config)
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "arkav/lualine-lsp-progress"
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
                        "filename",
                        "lsp_progress",
                    },
                },
                extensions = { "lazy", "nvim-dap-ui" },
            })
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup({
                replace = {
                    ["<Space>"] = "SPC",
                    ["<CR>"] = "RET",
                    ["<Tab>"] = "TAB",
                },
            })
        end,
    }
}
