return {
    {
        "williamboman/mason.nvim",
        build = ":MasonInstallAll",
        event = "VeryLazy",
        config = function()
            local ensure_installed = {
                "shfmt",
            }

            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            api.nvim_create_user_command("MasonInstallAll", function()
                vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
            end, {})
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

            keymap.set("n", "<leader>sc", dap.continue, { desc = "Start/continue" })
            keymap.set("n", "<leader>si", dap.step_into, { desc = "Step into" })
            keymap.set("n", "<leader>so", dap.step_over, { desc = "Step over" })
            keymap.set("n", "<leader>su", dap.step_out, { desc = "Step out" })
            keymap.set("n", "<leader>sb", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
            keymap.set("n", "<leader>sB", function()
                dap.set_breakpoint(fn.input("Breakpoint condition: "))
            end, { desc = "Set breakpoint" })

            dapui.setup()

            keymap.set("n", "<leader>st", dapui.toggle, { desc = "Toggle" })

            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"] = dapui.close

            require("neodev").setup({
                library = { plugins = { "nvim-dap-ui" }, types = true },
            })
        end
    },

    {
        "rshkarin/mason-nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-lint",
        },
        config = function()
            require("mason-nvim-lint").setup({
                ensure_installed = {
                    "selene",
                    "revive",
                    "shellcheck",
                    "vint",
                }
            })
        end,
    },

    {
        "mhartington/formatter.nvim",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "<leader>f", "<cmd>Format<cr>", desc = "Format" },
        },
        config = function()
            require("formatter").setup({
                filetype = {
                    sh = {
                        require("formatter.filetypes.sh").shfmt,
                    },
                    ["*"] = {
                        require("formatter.filetypes.any").remove_trailing_whitespace,
                        function()
                            local defined_types = require("formatter.config").values.filetype
                            if defined_types[vim.bo.filetype] ~= nil then
                                return nil
                            end
                            lsp.buf.format({ async = true })
                        end,
                    },
                },
            })
        end
    }
}
