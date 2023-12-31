{ inputs, lib, pkgs, config, outputs, qbankPath, ... }:
let
  inherit (inputs.nix-colors) colorSchemes;
in
{
  imports = [
    inputs.nix-colors.homeManagerModule
    (import ../features/cli { inherit pkgs qbankPath lib config; })
    ../features/helix
    ../features/development
    ../features/productivity
    ../features/multimedia
    ../features/pass
    ./wpaperd
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      # FIXME
      permittedInsecurePackages = [
        "openssl-1.1.1u"
        "nodejs-14.21.3"
        "nodejs-16.20.2"
        "electron-25.9.0"
      ];
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "dsod";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.05";
    sessionPath = [ "$HOME/.local/bin" ];
  };
  home.file.".scripts" = {
    source = ./scripts;
    recursive = true;
  };

  colorscheme = lib.mkDefault colorSchemes.dracula;
  home.file.".colorscheme".text = config.colorscheme.slug;
}
