vim.lsp.set_log_level("debug")

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
                enable = false,
              },
              diagnostics = {
                enable = false,
              },
            },
          },
        },
        psalm = {
          cmd = { "vendor/bin/psalm.phar", "--language-server", "--verbose" },
        },
      },
    },
  },
}
