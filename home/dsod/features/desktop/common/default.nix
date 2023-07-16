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
  ];

  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    xdg-utils-spawn-terminal
  ];
}
