{lib, pkgs, config, ...}: {
  imports = [
    ./kcachegrind.nix
    ./lazygit.nix
  ];
}
