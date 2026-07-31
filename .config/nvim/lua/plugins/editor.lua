return {
    {
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
        dependencies = {
            "akinsho/org-bullets.nvim",
            "dhruvasagar/vim-table-mode",
        },
        config = function()
            require("orgmode").setup({
                org_agenda_files = "Agenda/**/*",
                org_default_notes_file = "Notes/notes.org",
            })

            require("org-bullets").setup()
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
        },
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    if vim.list_contains(require("nvim-treesitter").get_available(), vim.treesitter.language.get_lang(args.match)) then
                        vim.treesitter.start(args.buf)
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })

            require("treesitter-context").setup({
                enable = true,
            })

            keymap.set("n", "[c", function()
                require("treesitter-context").go_to_context()
            end, { desc = "Go to context" })
        end,
    },

    {
        "RRethy/vim-illuminate",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
            api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
            api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
        end,
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    {
        "saghen/blink.cmp",
        build = function()
            require("blink.cmp").build():pwait()
        end,
        dependencies = {
            "saghen/blink.lib",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("blink.cmp").setup({
                completion = {
                    documentation = {
                        auto_show = true,
                    },
                },
                signature = {
                    enabled = true,
                },
                cmdline = {
                    keymap = {
                        preset = "inherit",
                    },
                    completion = {
                        menu = {
                            auto_show = true,
                        },
                    },
                },
            })
        end,
    },

    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("Comment").setup()
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                numhl = true,
                current_line_blame = true,
                current_line_blame_opts = {
                    ignore_whitespace = false,
                },
            })
        end,
    },

    {
        "lewis6991/spaceless.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("spaceless").setup()
        end,
    },

    {
        "lukas-reineke/headlines.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("headlines").setup({
                markdown = {
                    fat_headline_upper_string = "󰕱",
                    fat_headline_lower_string = "󰕱",
                },
                rmd = {
                    fat_headline_upper_string = "󰕱",
                    fat_headline_lower_string = "󰕱",
                },
                norg = {
                    fat_headline_upper_string = "󰕱",
                    fat_headline_lower_string = "󰕱",
                },
                org = {
                    fat_headline_upper_string = "󰕱",
                    fat_headline_lower_string = "󰕱",
                },
            })
        end
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        main = "ibl",
        config = function()
            require("ibl").setup()
        end,
    },

    {
        "folke/zen-mode.nvim",
        keys = {
            { "<leader>z", "<CMD>ZenMode<CR>", desc = "Toggle Zen mode" },
        },
        dependencies = {
            {
                "folke/twilight.nvim",
                config = function()
                    require("twilight").setup({
                        context = 20,
                        exclude = { "alpha" },
                    })
                end,
            }
        },
        config = function()
            require("zen-mode").setup({
                window = {
                    backdrop = 1,
                    width = 200,
                },
                plugins = {
                    twilight = { enabled = true },
                    gitsigns = { enabled = true },
                },
            })
        end,
    },

    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("colorizer").setup({
                filetypes = { "*" },
                buftypes = { "*" },
                user_default_options = {
                    RRGGBBAA = true,
                    AARRGGBB = true,
                    css = true,
                    tailwind = true,
                    sass = { enable = true, parsers = { "css" } },
                    always_update = true,
                },
            })
        end,
    }
}
