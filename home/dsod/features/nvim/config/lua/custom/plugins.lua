local overrides = require("custom.configs.overrides")
local treeSitterParserPath = vim.fn.stdpath("config")

---@type NvPluginSpec[]
local plugins = {

  { "folke/lazy.nvim", dev = true, version = "*" },  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
      dev = true,
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
      dev = true,
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },


  {
    "nvim-lua/plenary.nvim",
      dev = true,
  },

  {
    "NvChad/base46",
      dev = true,
  },

  {
    "NvChad/ui",
      dev = true,
      lazy = false
  },

  {
    "NvChad/nvterm",
      dev = true,
  },

  {
    "NvChad/nvim-colorizer.lua",
      dev = true,
  },

  {
    "nvim-tree/nvim-web-devicons",
      dev = true,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
      dev = true,
      main = "ibl"
  },

  {
    "nvim-treesitter/nvim-treesitter",
      dev = true,
      opts = function()
        local conf = require "plugins.configs.treesitter"
        conf.auto_install = false
        conf.ensure_installed = {}
        return conf
      end,
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
      dev = true,
  },

  -- lsp stuff
  {
    "williamboman/mason.nvim",
      dev = true,

    cmd = { },
    enabled = false,
  },

  {
    "neovim/nvim-lspconfig",
      dev = true,
  },

  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
      dev = true,

      denepdencies = {
        {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dev = true,
        dependencies = {"rafamadriz/friendly-snippets", dev = true},
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("plugins.configs.others").luasnip(opts)
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        dev = true,
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
        {"saadparwaiz1/cmp_luasnip", dev = true},
        {"hrsh7th/cmp-nvim-lua", dev = true},
        {"hrsh7th/cmp-nvim-lsp", dev = true},
        {"hrsh7th/cmp-buffer", dev = true},
        {"hrsh7th/cmp-path", dev = true},
    },
  },

  {
    "numToStr/Comment.nvim",
      dev = true,
  },

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
      dev = true,
  },

  {
    "nvim-telescope/telescope.nvim",
      dev = true,
    dependencies = { {"nvim-treesitter/nvim-treesitter", dev = true}, { "nvim-telescope/telescope-fzf-native.nvim", dev = true, build = "make" }},
  },

  -- Only load whichkey after all the gui
  {
    "folke/which-key.nvim",
      dev = true,
  },

}

return plugins
