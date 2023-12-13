return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        keys = {
            { "<leader>wf", "<CMD>Telescope find_files hidden=true<CR>", desc = "Telescope find files" },
            { "<leader>gf", "<CMD>Telescope git_files<CR>",              desc = "Telescope git files" },
            { "<leader>wb", "<CMD>Telescope buffers<CR>",                desc = "Telescope buffers" },
            { "<leader>wg", "<CMD>Telescope live_grep<CR>",              desc = "Telescope live grep" },
            { "<leader>ws", "<CMD>Telescope lsp_workspace_symbols<CR>",  desc = "Telescope lsp workspace symbols" },
            { "<leader>s",  "<CMD>Telescope lsp_document_symbols<CR>",   desc = "Telescope lsp document symbols" },
            { "<leader>h",  "<CMD>Telescope help_tags<CR>",              desc = "Telescope help tags" },
            { "<leader>cd", "<CMD>Telescope zoxide list<CR>",            desc = "Telescope zoxide list" },
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
                    layout_config = {
                        horizontal = { preview_width = 0.6 },
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
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
    },

    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<CMD>UndotreeToggle<CR>", desc = "Toggle Undotree" },
        }
    },

    {
        "vifm/vifm.vim",
        config = function()
            keymap.set("n", "<leader>.", "<CMD>Vifm<CR>", { desc = "Launch Vifm" })
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
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            keymap.set("n", "<leader>mt", mark.toggle_file, { desc = "Toggle harpoon mark" })
            keymap.set("n", "<leader>mm", ui.toggle_quick_menu)

            keymap.set("n", "<leader>mh", function() ui.nav_file(1) end, { desc = "Go to the 1st file in harpoon list" })
            keymap.set("n", "<leader>mj", function() ui.nav_file(2) end, { desc = "Go to the 2nd file in harpoon list" })
            keymap.set("n", "<leader>mk", function() ui.nav_file(3) end, { desc = "Go to the 3rd file in harpoon list" })
            keymap.set("n", "<leader>ml", function() ui.nav_file(4) end, { desc = "Go to the 4th file in harpoon list" })
        end,
    },

    {
        "ThePrimeagen/vim-be-good",
        cmd = "VimBeGood",
    }
}
