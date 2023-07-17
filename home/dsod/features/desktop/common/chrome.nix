{ config, pkgs, lib, ... }:
{
  programs.google-chrome = {
    enable = true;
     commandLineArgs = [
        "--gtk-version=4"
      ];
  };

  home.sessionVariables.BROWSER = "google-chrome-stable";

}
