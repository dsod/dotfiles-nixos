{ config, lib, ... }: {
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
}
