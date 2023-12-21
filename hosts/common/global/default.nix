# This file (and the global directory) holds config that i use on all hosts
{ inputs, outputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./auto-upgrade.nix
    ./fish.nix
    ./locale.nix
    ./nix.nix
    ./systemd-initrd.nix
    ./polkit-agent.nix
    ./gnome-disks.nix
    ./yubikey.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      # FIXME
      permittedInsecurePackages = [
        "openssl-1.1.1u"
        "nodejs-14.21.3"
        "nodejs-16.20.2"
        "electron-25.9.0"
      ];
    };
  };

  environment.enableAllTerminfo = true;
  hardware.enableRedistributableFirmware = true;

}
