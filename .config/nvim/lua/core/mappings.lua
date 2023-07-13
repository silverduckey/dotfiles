-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Quick launch Netrw
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Toggle to see last session result. Without this, you can"t see session output in case of unhandled exception.
local dap = require "dap"
local dapui = require "dapui"

vim.keymap.set("n", "<leader>dt", dapui.toggle)

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

-- Launch Neovim terminal
vim.keymap.set("n", "<leader>t", vim.cmd.term)
