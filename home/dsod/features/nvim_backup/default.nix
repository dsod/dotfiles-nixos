{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

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
      nodePackages.prettier # JavaScript / TypeScript / CSS / HTML
      php81Packages.php-cs-fixer # PHP

      # Linters
      php81Packages.psalm # PHP
      nodePackages.eslint

    ];
  };
  xdg.configFile."nvim" = {
    recursive = true;
    source = ./config;
  };
}
