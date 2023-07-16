{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = false;
  users.users.dsod = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ] ++ ifTheyExist [
      "minecraft"
      "network"
      "netowkrmanager"
      "wireshark"
      "i2c"
      "mysql"
      "docker"
      "podman"
      "git"
      "libvirtd"
      "deluge"
    ];

    packages = [ pkgs.home-manager ];
  };

  home-manager.users.dsod = import ../../../../home/dsod/${config.networking.hostName}.nix;
  

  services.geoclue2.enable = true;
  security.pam.services = { swaylock = { }; };
}
