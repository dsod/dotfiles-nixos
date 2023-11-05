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
              diagnostics = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
}
