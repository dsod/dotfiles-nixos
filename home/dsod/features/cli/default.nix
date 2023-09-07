{ pkgs, lib, config, qbankPath, ... }: {
  imports = [
    ./bash.nix
    ./bat.nix
    ./direnv.nix
    (import ./fish.nix { inherit pkgs qbankPath lib config; })
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./nix-index.nix
    ./pfetch.nix
    ./nnn.nix
    ./screen.nix
    ./shellcolor.nix
    ./starship.nix
    ./xdg.nix
  ];
  home.packages = with pkgs; [
    comma # Install and run programs by sticking a , before them
    distrobox # Nice escape hatch, integrates docker images with my environment

    bc # Calculator
    bottom # System viewer
    ncdu # TUI disk usage
    exa # Better ls
    ripgrep # Better grep
    fd # Better find
    diffsitter # Better diff
    jq # JSON pretty printer and manipulator
    trekscii # Cute startrek cli printer
    nil # Nix LSP
    nixfmt # Nix formatter

    ltex-ls # Spell checking LSP
  ];
  home.file.".local/bin/nnn-hx".source = ./bin/nnn-hx.sh;
}
