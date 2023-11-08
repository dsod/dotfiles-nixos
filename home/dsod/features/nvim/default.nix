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
      nodePackages.eslint # JS/TS
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
    ];
  };

  home.packages = with pkgs; [
    php81Packages.psalm
  ];

  xdg.configFile."nvim" = {
    recursive = true;
    source = ./config;
  };
}
