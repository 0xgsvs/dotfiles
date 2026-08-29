return {
  -- theme
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "medium" -- "hard", "medium" (default), "soft"
      vim.g.gruvbox_material_foreground = "material" -- "material" (default), "mix", "original"
      vim.g.gruvbox_material_enable_italic = true
      vim.cmd.colorscheme "gruvbox-material"
    end,
  },
  -- file managing , picker etc
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      require("oil").setup {
        keymaps = {
          ["<A-h>"] = "actions.parent",
          ["<A-l>"] = "actions.select",
          ["H"] = "actions.toggle_hidden",
        },
      }
    end,
  },
  -- key suggestions
  {
    "folke/which-key.nvim",
    lazy = false,
    cmd = "WhichKey",
    opts = function()
      return require "configs.whichkey"
    end,
    keys = { { "<Space>", desc = "Leader" }, "<c-w>", '"', "'", "`", "c", "v", "g" },
  },
  -- formatting!
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    opts = function()
      return require "configs.conform"
    end,
  },
  -- lsp stuff
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre" },
    opts = function()
      require "configs.lspconfig"
    end,
    config = function() end,
  },
  -- nvim treesitter is back from dead
  -- TODO: add nvim-treesitter again and remove custom parsers
  -- snippet plugin
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    opts = function()
      return {
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      }
    end,
    config = function(_, opts)
      require("luasnip").config.set_config(opts)

      local ls = require "luasnip"
      local cmp = require "blink.cmp"
      local map = vim.keymap.set

      require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/snippets/" }

      map({ "i", "s" }, "<tab>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
          cmp.hide()
        end
      end, { silent = true })

      map({ "i", "s" }, "<S-tab>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    event = "LspAttach",
    cmd = "Telescope",
    opts = function()
      return require "configs.telescope"
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)
      telescope.load_extension "ui-select"
      telescope.load_extension "fzf"
    end,
  },
  -- flash
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    keys = {
      {
        "s",
        function()
          require("flash").jump()
        end,
        mode = { "n", "x", "o" },
        desc = "Flash Jump",
      },
    },
    opts = {
      jump = {
        autojump = true, -- Automatically jump when there's only one match
      },
      modes = {
        char = {
          enabled = false, -- stops flash from hooking f/F/t/T
        },
      },
    },
    config = function(_, opts)
      require("flash").setup(opts)
      vim.keymap.set({ "n", "v" }, "f", "<ESC>", { noremap = true, silent = true })
    end,
  },
  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = {},
    config = function() end,
  },
  -- mini.ai
  {
    "echasnovski/mini.ai",
    version = false,
    config = function()
      require("mini.ai").setup {}
    end,
  },
  -- mini move
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<A-h>",
        right = "<A-l>",
        down = "<A-j>",
        up = "<A-k>",

        -- Move current line in Normal mode
        line_left = "",
        line_right = "",
        line_down = "",
        line_up = "",
      },

      -- Options which control moving behavior
      options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
      },
    },
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { "string" },
      skip_unbalanced = true,
      markdown = true,
    },
  },
  {
    "nvim-mini/mini.surround",
    version = false,
    lazy = false,
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "saghen/blink.lib",
      "rafamadriz/friendly-snippets",
    },
    build = function()
      require("blink.cmp").build():wait(60000)
    end,
    opts = function()
      return require "configs.blink"
    end,
  },
}
