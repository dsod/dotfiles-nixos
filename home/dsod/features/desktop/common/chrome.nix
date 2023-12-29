{ config, pkgs, lib, ... }:
{
  programs.google-chrome = {
    enable = true;
     commandLineArgs = [
        "--password-store=gnome-libsecret"
      ];
  };

  home.sessionVariables = {
    BROWSER = "google-chrome-stable";
    DEFAULT_BROWSER = "google-chrome-stable";
  };

}
