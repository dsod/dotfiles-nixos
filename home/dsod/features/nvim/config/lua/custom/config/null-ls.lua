local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.prettierd,
  b.diagnostics.eslint_d,
  b.code_actions.eslint_d

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,
  b.diagnostics.clang,

  -- Nix
  b.formatting.nixpkgs-fmt,

  -- PHP
  b.formatting.php-cs-fixer
  b.diagnostics.psalm
}

null_ls.setup {
  sources = sources,
}
