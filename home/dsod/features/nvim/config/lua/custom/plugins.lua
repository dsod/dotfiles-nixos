local overrides = require "custom.configs.overrides"
local treeSitterParserPath = vim.fn.stdpath "config"

---@type NvPluginSpec[]
local plugins = {

  {
    "neovim/nvim-lspconfig",

    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",

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

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    cmd = {},
    enabled = false,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",

        -- web dev
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "json",

        -- languages
        "php",
        "phpdoc",
        "sql",

        -- low level
        "c",
        "zig",
        "go",

        -- system
        "bash",
        "dockerfile",
        "fish",
        "jq",
        "nix",
        "ssh_config",
        "terraform",
        "toml",
        "yaml",
        "xml"
      },
    },
  },
}

return plugins
