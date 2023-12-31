return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        html = {},
        cssls = {},
        clangd = {},
        lua_ls = {},
        bashls = {},
        nil_ls = {},
        intelephense = {
          init_options = {
            licenceKey = "00HAMU0OFBGZNXO",
          },
          settings = {
            intelephense = {
              telemetry = false,
              format = {
                enable = true,
              },
              diagnostics = {
                enable = true,
              },
            },
          },
        },
        smarty_ls = {
          cmd = {
            vim.fn.stdpath("data") .. "/lazy/vscode-smarty-langserver-extracted/bin/smarty-language-server",
            "--stdio",
          },
        },
      },
    },
  },
  {
    "landeaux/vscode-smarty-langserver-extracted",
    build = "npm install && npm run build",
  },
}
