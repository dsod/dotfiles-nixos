local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.prettierd,
  b.diagnostics.eslint_d,
  b.code_actions.eslint_d,

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,
  b.diagnostics.clang_check,

  -- Nix
  b.formatting.nixpkgs_fmt,

  -- PHP
  b.formatting.phpcsfixer.with({
    extra_args = {"--rules", "'@PSR12,single_quote,{\"array_syntax\": {\"syntax\": \"short\"}}'"}
  }),
  b.diagnostics.psalm
}

null_ls.setup {
  sources = sources,
}
