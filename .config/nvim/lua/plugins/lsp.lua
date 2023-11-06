return {
    {
        "williamboman/mason.nvim",
        build = ":MasonInstallAll",
        event = "VeryLazy",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup {
                automatic_installation = true,
            }

            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local on_attach = function(client)
                keymap.set("n", "gD", lsp.buf.declaration, { desc = "Go to declaration" })
                keymap.set("n", "gd", lsp.buf.definition, { desc = "Go to definition" })
                keymap.set("n", "K", lsp.buf.hover, { desc = "Hover" })
                keymap.set("n", "gi", lsp.buf.implementation, { desc = "Go to implementation" })
                keymap.set("i", "<C-k>", lsp.buf.signature_help, { desc = "Signature help" })
                keymap.set("n", "<space>wa", lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
                keymap.set("n", "<space>wr", lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })
                keymap.set("n", "<space>wl", function()
                    print(vim.inspect(lsp.buf.list_workspace_folders()))
                end, { desc = "List workspace folders" })
                keymap.set("n", "<space>D", lsp.buf.type_definition, { desc = "Type definition" })
                keymap.set("n", "<space>rn", lsp.buf.rename, { desc = "Rename" })
                keymap.set({ "n", "v" }, "<space>ca", lsp.buf.code_action, { desc = "Code action" })
                keymap.set("n", "gr", lsp.buf.references, { desc = "References" })
                keymap.set("n", "<space>f", lsp.buf.format, { desc = "Format" })
            end

            keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Diagnostic" })
            keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
            keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
            keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Quickfix" })

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig.clangd.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig.gopls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig.tsserver.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig.eslint.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig.bashls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig.vale_ls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig.vimls.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            "folke/neodev.nvim",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            require("mason-nvim-dap").setup({
                ensure_installed = {
                    "codelldb",
                    "delve",
                    "bash",
                },
                handlers = {},
            })

            keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/continue" })
            keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
            keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
            keymap.set("n", "<leader>du", dap.step_out, { desc = "Step out" })
            keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
            keymap.set("n", "<leader>dB", function()
                dap.set_breakpoint(fn.input("Breakpoint condition: "))
            end, { desc = "Set breakpoint" })

            dapui.setup()

            keymap.set("n", "<leader>dt", dapui.toggle, { desc = "Toggle" })

            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"] = dapui.close

            require("neodev").setup({
                library = { plugins = { "nvim-dap-ui" }, types = true },
            })
        end
    },

    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = {
                    "shfmt",
                    "selene",
                    "revive",
                    "shellcheck",
                    "vint",
                },
                handlers = {},
            })
        end,
    }
}
