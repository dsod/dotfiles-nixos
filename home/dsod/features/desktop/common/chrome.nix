{ config, pkgs, lib, ... }:
{
  programs.google-chrome = {
    enable = true;
     commandLineArgs = [
      ];
  };

  home.sessionVariables.BROWSER = "google-chrome-stable";

}
