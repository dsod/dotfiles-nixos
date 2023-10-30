{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      mason-nvim
      nvim-colorizer-lua
      nvchad-ui
      nvim-treesitter.withAllGrammars
      null-ls-nvim
      nvim-cmp
      luasnip
      friendly-snippets
      base46
      nvterm
      nvim-web-devicons
      nvim-tree-lua
      gitsigns-nvim
      nvim-lspconfig
      mason-nvim
      telescope-nvim
      telescope-fzf-native-nvim
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
    php81Packages.php-cs-fixer # PHP

    # Linters
    php81Packages.psalm # PHP
    nodePackages.eslint_d

    ];
  };
  xdg.configFile."nvim" = {
    recursive = true;
    source = ./config;
  };
  xdg.configFile."nvim/parser".source = "${pkgs.symlinkJoin {
      name = "treesitter-parsers";
      paths = (pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies);
    }}/parser";

  xdg.configFile."nvim/lua/custom/lazy_nvim.lua".text = ''
    local M = {
      performance = {
        reset_packpath = false,
        rtp = {
          reset = false,
        }
      },
      dev = {
        path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start"
      },
      install = {
        missing = false,
      },
    }

    return M
  '';
  }
