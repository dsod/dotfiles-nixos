{ pkgs, lib, outputs, ... }:
{
  imports = [
    ./deluge.nix
    ./discord.nix
    ./chrome.nix
    ./font.nix
    ./gtk.nix
    ./pavucontrol.nix
    ./playerctl.nix
    ./qt.nix
    ./slack.nix
    ./filezilla.nix
    ./dbeaver.nix
    ./rclone.nix
    ./gparted.nix
    ../../cloud
  ];
}
