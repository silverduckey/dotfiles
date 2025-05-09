return {
    {
        "nvim-orgmode/orgmode",
        dependencies = {
            "akinsho/org-bullets.nvim",
            "dhruvasagar/vim-table-mode",
        },
        event = "VeryLazy",
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
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "lua",
                    "c",
                    "cpp",
                    "go",
                    "rust",
                    "vim",
                    "vimdoc",
                    "query",
                    "bash",
                    "markdown",
                    "markdown_inline",
                    "regex",
                    "toml",
                    "yaml",
                    "ini",
                },
                ignore_install = {
                    "org",
                },
                auto_install = true,
                highlight = {
                    enable = true,
                },
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
        "yetone/avante.nvim",
        event = { "BufReadPre", "BufNewFile" },
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-tree/nvim-web-devicons",
            {
                "zbirenbaum/copilot.lua",
                event = "VeryLazy",
                config = function()
                    require("copilot").setup()
                end,
            },
            {
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                config = function()
                    require("img-clip").setup({
                        default = {
                            embed_image_as_base64 = false,
                            prompt_for_file_name = false,
                            drag_and_drop = {
                                insert_mode = true,
                            },
                        },
                    })
                end
            },
            {
                "MeanderingProgrammer/render-markdown.nvim",
                ft = { "markdown", "Avante" },
                config = function()
                    require("render-markdown").setup({
                        file_types = {
                            "markdown",
                            "Avante",
                        },
                    })
                end,
            },
        },
        config = function()
            require("avante").setup({
                provider = "copilot",
            })
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            {
                "L3MON4D3/LuaSnip",
                build = "make install_jsregexp",
                dependencies = {
                    "rafamadriz/friendly-snippets",
                },
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            {
                "windwp/nvim-autopairs",
                config = function()
                    require("nvim-autopairs").setup({
                        disable_in_replace_mode = false,
                    })
                end,
            },
        },
        config = function()
            local luasnip = require("luasnip")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip" },
                    { name = "orgmode" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
            })

            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "git" },
                }, {
                    { name = "buffer" },
                }),
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
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
            require("ibl").setup({
                indent = {
                    char = "",
                },
                scope = {
                    char = "",
                },
            })
        end,
    },

    {
        "folke/twilight.nvim",
        lazy = true,
        config = function()
            require("twilight").setup({
                context = 20,
                exclude = { "alpha" },
            })
        end,
    },

    {
        "folke/zen-mode.nvim",
        keys = {
            { "<leader>z", "<CMD>ZenMode<CR>", desc = "Toggle Zen mode" },
        },
        dependencies = {
            "folke/twilight.nvim",
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
