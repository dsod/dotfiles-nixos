return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "php_cs_fixer" },
        smarty = { "php_cs_fixer" },
        nix = { "nixpkgs_fmt" },
        xml = { "xmlformat" },
      },
      formatters = {
        xmlformat = {
          args = {
            "--config-file=/home/dsod/.config/nvim/formatters/xmlformat.conf",
            "-",
          },
        },
      },
    },
  },
}
