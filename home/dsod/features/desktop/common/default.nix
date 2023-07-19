{ pkgs, lib, outputs, ... }:
{
  imports = [
    ./deluge.nix
    ./discord.nix
    ./chrome.nix
    ./vscode.nix
    ./font.nix
    ./gtk.nix
    ./kdeconnect.nix
    ./pavucontrol.nix
    ./playerctl.nix
    ./qt.nix
    ./slack.nix
    ./filezilla.nix
    ../../cloud
  ];
}
