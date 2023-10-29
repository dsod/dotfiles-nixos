{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  # Use this to create a plugin from an input
  mkNeovim = pkgs.callPackage ./mkNeovim.nix {};

  all-plugins = with pkgs.vimPlugins; [
    lazy-nvim
    mason-nvim
    nvchad-ui
    nvim-treesitter.withAllGrammars
    null-ls-nvim
    nvim-cmp
    base46
    nvterm
    nvim-web-devicons
    nvim-tree-lua
    gitsigns-nvim
    nvim-lspconfig
    mason-nvim
    telescope-nvim
    nvim-autopairs
    indent-blankline-nvim
    which-key-nvim
  ];

  extraPackages = with pkgs; [
    # LSP servers
    lua-language-server # Lua
    clang-tools # C/C++
    nodePackages.bash-language-server
    nodePackages.intelephense
    nodePackages.vscode-langservers-extracted # Includes a lot of stuff. eslint, css, html, and so on
    nodePackages.typescript-language-server # TypeScript / JavaScript
    gopls # Go
    terraform-ls # Terraform f
    docker-compose-language-service # Docker compose
    nodePackages.dockerfile-language-server-nodejs # Docker
    nil # nix

    # Formatters
    stylua # Lua
    nixpkgs-fmt # Nix
    nodePackages.prettier_d_slim # JavaScript / TypeScript / CSS / HTML
    php81Packages.phpcs # PHP

    # Linters
    php81Packages.psalm # PHP
    nodePackages.eslint_d
  ];
in {
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # You can add as many derivations as you like.
}
