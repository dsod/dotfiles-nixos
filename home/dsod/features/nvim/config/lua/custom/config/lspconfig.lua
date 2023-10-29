local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a tabuflinePrev
local servers = { "html", "cssls", "jsonls", "tsserver", "clangd", "lua_ls", "bashls", "gopls", "terraformls", "docker_compose_language_service", "dockerls", "nil" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

--
lspconfig.intelephense.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        licenceKey = "00HAMU0OFBGZNXO",
    },
 }
