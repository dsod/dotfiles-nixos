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
      nodePackages.vscode-langservers-extracted # HTML, CSS
      nodePackages.typescript-language-server # TypeScript / JavaScript
      gopls # Go
      terraform-ls # Terraform f
      docker-compose-language-service # Docker compose
      nodePackages.dockerfile-language-server-nodejs # Docker
      nodePackages.yaml-language-server # Yaml
      nil # nix
      marksman # Markdown

      # Formatters
      stylua # Lua
      nixpkgs-fmt # Nix
      nodePackages.prettier # JavaScript / TypeScript / CSS / HTML
      php81Packages.php-cs-fixer # PHP
      xmlformat # XML
      yamlfmt # Yaml
      nodePackages.markdownlint-cli # Markdown
      shfmt # Bash
      gofumpt # Go

      # Linters
      php81Packages.psalm # PHP
      nodePackages.eslint_d # JS/TS
      vale # Markdown
      nodePackages.stylelint # css
      yamllint # Yaml
      gotools # Go
      hadolint # Dockergo
      html-tidy # HTML

      # Other tools
      gomodifytags # Go modify struct tags
      impl # For generating interface stubs

      # Debugging
      delve # Go
      #vscode-js-debug
      #vscode-php-debug
    ];
  };

  #xdg.dataFile."vscode-js-debug" = {
  #  source = pkgs.vscode-js-debug;
  #  recursive = true;
  #};

  #xdg.dataFile."vscode-php-debug" = {
  #  source = pkgs.vscode-php-debug;
  #  recursive = true;
  #};

  xdg.configFile."nvim" = {
    recursive = true;
    source = ./config;
  };
}
