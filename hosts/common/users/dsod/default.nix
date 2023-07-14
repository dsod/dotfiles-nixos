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
  users.users.root.hashedPassword = "$6$2vqBJecqkl0PKh74$46XZXoDc0d2Dsa9w1E8lcXD9ycFp4G//1c2lqRBqvWM1ukcQ74AqyALpyRwf3ia4fu4G4tIv7SwurCHydLAOc";
  users.users.dsod.hashedPassword = "$6$2vqBJecqkl0PKh74$46XZXoDc0d2Dsa9w1E8lcXD9ycFp4G//1c2lqRBqvWM1ukcQ74AqyALpyRwf3ia4fu4G4tIv7SwurCHydLAOc";

  services.geoclue2.enable = true;
  security.pam.services = { swaylock = { }; };
}
