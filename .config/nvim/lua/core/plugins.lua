local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, {})
      vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, {})
      vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, {})
      vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, {})
    end,
  },
  {
    "navarasu/onedark.nvim",
    config = function()
      vim.o.background = "dark"
      require("onedark").setup {
        -- Main options --
        style = "dark",               -- Default theme style. Choose between "dark", "darker", "cool", "deep", "warm", "warmer" and "light"
        transparent = false,          -- Show/hide background
        term_colors = true,           -- Change terminal color as per the selected theme style
        ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

        -- toggle theme style ---
        toggle_style_key = nil,                                                              -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma separated, For e.g., keywords = "italic,bold"
        code_style = {
          comments = "italic",
          keywords = "bold,italic",
          functions = "none",
          strings = "none",
          variables = "bold"
        },
        -- Lualine options --
        lualine = {
          transparent = false, -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {},     -- Override default colors
        highlights = {}, -- Override highlight groups

        -- Plugins Config --
        diagnostics = {
          darker = true,     -- darker colors for diagnostic
          undercurl = true,  -- use undercurl instead of underline for diagnostics
          background = true, -- use background color for virtual text
        }
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup {
        -- A list of servers to automatically install if they"re not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
        -- This setting has no relation with the `automatic_installation` setting.
        ---@type string[]
        ensure_installed = {
          "lua_ls",
          "clangd",
          "gopls",
          "rust_analyzer",
          "bashls",
          "vimls",
          "remark_ls",
        },

        -- Whether servers that are set up (via lspconfig) should be automatically installed if they"re not already installed.
        -- This setting has no relation with the `ensure_installed` setting.
        -- Can either be:
        --   - false: Servers are not automatically installed.
        --   - true: All servers set up via lspconfig are automatically installed.
        --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
        --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
        ---@type boolean
        automatic_installation = false,

        -- See `:h mason-lspconfig.setup_handlers()`
        ---@type table<string, fun(server_name: string)>?
        handlers = nil,
      }
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        -- A list of sources to install if they"re not already installed.
        -- This setting has no relation with the `automatic_installation` setting.
        ensure_installed = {
          "stylua",
          "selene",
          "cpplint",
          "golangci-lint",
          "beautysh",
          "shellcheck",
          "vint",
        },
        -- Run `require("null-ls").setup`.
        -- Will automatically install masons tools based on selected sources in `null-ls`.
        -- Can also be an exclusion list.
        -- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
        automatic_installation = false,
        -- See [#handlers-usage](#handlers-usage) section
        handlers = nil,
      })
    end,
  },
  {
    "lukas-reineke/lsp-format.nvim",
    config = function()
      require("lsp-format").setup { on_attach = require("lsp-format").on_attach }
      require("lspconfig").lua_ls.setup { on_attach = require("lsp-format").on_attach }
      require("lspconfig").clangd.setup { on_attach = require("lsp-format").on_attach }
      require("lspconfig").gopls.setup { on_attach = require("lsp-format").on_attach }
      require("lspconfig").rust_analyzer.setup { on_attach = require("lsp-format").on_attach }
      require("lspconfig").bashls.setup { on_attach = require("lsp-format").on_attach }
      require("lspconfig").remark_ls.setup { on_attach = require("lsp-format").on_attach }
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap", },
    config = function()
      require("mason-nvim-dap").setup({
        -- A list of adapters to install if they"re not already installed.
        -- This setting has no relation with the `automatic_installation` setting.
        ensure_installed = { "cppdbg", "deleve", "bash", },

        -- NOTE: this is left here for future porting in case needed
        -- Whether adapters that are set up (via dap) should be automatically installed if they"re not already installed.
        -- This setting has no relation with the `ensure_installed` setting.
        -- Can either be:
        --   - false: Daps are not automatically installed.
        --   - true: All adapters set up via dap are automatically installed.
        --   - { exclude: string[] }: All adapters set up via mason-nvim-dap, except the ones provided in the list, are automatically installed.
        --       Example: automatic_installation = { exclude = { "python", "delve" } }
        automatic_installation = false,

        -- See below on usage
        handlers = nil,
      })
    end,
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", },
    config = function()
      require("dapui").setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don"t feel like these are good choices.
        icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
        controls = {
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "b",
            run_last = "▶▶",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
      }
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",

    config = function()
      vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        disable_in_macro = false,       -- disable when recording or executing a macro
        disable_in_visualblock = false, -- disable when insert after visual block mode
        disable_in_replace_mode = true,
        ignored_next_char = [=[[%w%%%"%[%"%.%`%$]]=],
        enable_moveright = true,
        enable_afterquote = true,         -- add bracket pairs after quote
        enable_check_bracket_line = true, --- check bracket in same line
        enable_bracket_in_quote = true,   --
        enable_abbr = false,              -- trigger abbreviation
        break_undo = true,                -- switch for basic rule break undo sequence
        check_ts = false,
        map_cr = true,
        map_bs = true,   -- map the <BS> key
        map_c_h = false, -- Map the <C-h> key to delete a pair
        map_c_w = false, -- map <c-w> to delete a pair if possible
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = { "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline", "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", },
    config = function()
      local cmp = require "cmp"

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        })
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = "buffer" },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won"t work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })

      -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })

      -- Set up lspconfig.
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities = capabilities
      -- Enable autopairs
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require "nvim-treesitter.configs".setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
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
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (for "all")
        ignore_install = {},

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          disable = {},

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({})
    end,
  },
  {
    "glepnir/dashboard-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("dashboard").setup {
        theme = "hyper",
        config = {
          week_header = {
            enable = true,
          },
          shortcut = {
            {
              icon = " ",
              desc = "File Explorer",
              action = "Ex",
              key = "e",
            },
            {
              icon = "󰚰 ",
              desc = "Update",
              group = "Label",
              action = "Lazy sync",
              key = "u"
            },
          },
        },
        hide = {
          statusline = false,     -- hide statusline default is true
        },
        shortcut_type = "number", --  shorcut type "letter" or "number"
      }
    end,
  },
  {
    "kdheepak/tabline.nvim",
    dependencies = { "nvim-lualine/lualine.nvim", "nvim-tree/nvim-web-devicons", },
    config = function()
      require "tabline".setup {
        -- Defaults configuration options
        enable = true,
        options = {
          -- If lualine is installed tabline will use separators configured in lualine by default.
          -- These options can be used to override those settings.
          section_separators = { "", "" },
          component_separators = { "", "" },
          max_bufferline_percent = nil, -- set to nil by default, and it uses vim.o.columns * 2/3
          show_tabs_always = true,      -- always show tabs
          show_devicons = true,         -- this shows devicons in buffer section
          show_bufnr = false,           -- this appends [bufnr] to buffer section,
          show_filename_only = false,   -- shows base filename only instead of relative path in filename
          modified_icon = "+ ",         -- change the default modified icon
          modified_italic = true,       -- set to true by default; this determines whether the filename turns italic if modified
          show_tabs_only = false,       -- this shows only tabs instead of tabs + buffers
        }
      }
      vim.cmd [[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
    ]]
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = "onedark",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end,
  },
})
