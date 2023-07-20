{ pkgs, ... }:
{
  home.packages = with pkgs; [ alsa-utils spotify mpv ];
}
