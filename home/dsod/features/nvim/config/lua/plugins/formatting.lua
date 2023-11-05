return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "php_cs_fixer" },
        nix = { "nixpkgs_fmt" },
        css = { "prettier" },
        html = { "prettier" },
        xml = { "xmlformat" },
        markdown = { "markdownlint" },
      },
    },
  },
}
