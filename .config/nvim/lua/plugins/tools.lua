return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        keys = {
            { "<leader>wf", "<CMD>Telescope find_files<CR>",  desc = "Telescope find files" },
            { "<leader>gf", "<CMD>Telescope git_files<CR>",   desc = "Telescope git files" },
            { "<leader>wb", "<CMD>Telescope buffers<CR>",     desc = "Telescope buffers" },
            { "<leader>wg", "<CMD>Telescope live_grep<CR>",   desc = "Telescope live grep" },
            { "<leader>h",  "<CMD>Telescope help_tags<CR>",   desc = "Telescope help tags" },
            { "<leader>o",  "<CMD>Telescope oldfiles<CR>",    desc = "Telescope oldfiles" },
            { "<leader>cd", "<CMD>Telescope zoxide list<CR>", desc = "Telescope zoxide list" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            {
                "jvgrootveld/telescope-zoxide",
                dependencies = {
                    "nvim-lua/popup.nvim"
                },
            },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    sorting_strategy = "ascending",
                    layout_config = {
                        horizontal = { prompt_position = "top", preview_width = 0.6 },
                        width = 0.90,
                        height = 0.90,
                    },
                },
            })

            require("telescope").load_extension("fzf")
            require("telescope").load_extension("zoxide")
        end,
    },

    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<CMD>UndotreeToggle<CR>", desc = "Toggle Undotree" },
        }
    },

    {
        "lmburns/lf.nvim",
        dependencies = {
            "akinsho/toggleterm.nvim",
        },
        config = function()
            g.lf_netrw = 1
            require("lf").setup({
                winblend = 0,
                border = "rounded",
                height = fn.float2nr(fn.round(0.9 * o.lines)),
                width = fn.float2nr(fn.round(0.9 * o.columns)),
                escape_quit = false,
                highlights = {
                    NormalFloat = { link = "guibg" },
                },
            })

            keymap.set("n", "<leader>.", "<cmd>Lf<cr>", { desc = "Launch Lf" })
        end,
    },

    {
        "kdheepak/lazygit.nvim",
        keys = {
            { "<leader>gs", "<CMD>LazyGit<CR>", desc = "Launch LazyGit" },
        }
    },

    {
        "ThePrimeagen/harpoon",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            require("harpoon").setup({
                tabline = true,
            })

            api.nvim_set_hl(0, "HarpoonNumberInactive", { link = "TabLine" })
            api.nvim_set_hl(0, "HarpoonNumberActive", { link = "TabLineSel" })
            api.nvim_set_hl(0, "HarpoonActive", { link = "TabLineSel" })
            api.nvim_set_hl(0, "HarpoonInactive", { link = "TabLine" })

            keymap.set("n", "<leader>a", mark.toggle_file, { desc = "Toggle harpoon mark" })
            keymap.set("n", "<C-e>", ui.toggle_quick_menu)

            keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = "Go to the 1st file in harpoon list" })
            keymap.set("n", "<C-j>", function() ui.nav_file(2) end, { desc = "Go to the 2nd file in harpoon list" })
            keymap.set("n", "<C-k>", function() ui.nav_file(3) end, { desc = "Go to the 3rd file in harpoon list" })
            keymap.set("n", "<C-l>", function() ui.nav_file(4) end, { desc = "Go to the 4th file in harpoon list" })
        end,
    },

    {
        "ThePrimeagen/vim-be-good",
        cmd = "VimBeGood",
    }
}
