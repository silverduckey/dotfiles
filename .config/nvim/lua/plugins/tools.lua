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
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<CMD>UndotreeToggle<CR>", desc = "Toggle Undotree" },
        },
    },

    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>.", "<CMD>Yazi<CR>", desc = "Launch Yazi" }
        },
        config = function()
            require("yazi").setup({
                open_for_directories = true,
            })
        end
    },

    {
        "kdheepak/lazygit.nvim",
        keys = {
            { "<leader>gs", "<CMD>LazyGit<CR>", desc = "Launch LazyGit" },
        },
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local harpoon = require("harpoon")

            harpoon.setup()

            keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
            keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
            keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
            keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

            keymap.set("n", "<C-n>", function() harpoon:list():next() end)
            keymap.set("n", "<C-p>", function() harpoon:list():prev() end)
        end,
    },

    {
        "ThePrimeagen/vim-be-good",
        cmd = "VimBeGood",
    }
}
