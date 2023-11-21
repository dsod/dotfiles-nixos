-- let php-cs-fixer do formatting
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "php" },
  callback = function()
    vim.b.autoformat = false
  end,
})

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "php_cs_fixer" },
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
