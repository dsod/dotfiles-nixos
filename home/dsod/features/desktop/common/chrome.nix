{ config, pkgs, lib, ... }:
{
  programs.google-chrome = {
    enable = true;
  };

  home.sessionVariables.BROWSER = "google-chrome";

}
