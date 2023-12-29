{ lib, pkgs, config, ... }: {
  imports = [
    ./kcachegrind.nix
    ./vscode
  ];

  home.packages = with pkgs; [
    # LSP servers
    clang-tools # C/C++
    gopls # Go
    nil # nix

    # Formatters
    nixpkgs-fmt # Nix
    php81Packages.php-cs-fixer # PHP

    # Linters
    gotools # Go
  ];
}
