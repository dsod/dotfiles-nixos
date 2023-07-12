{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    xdg-utils
    xdg-user-dirs
  ];

  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    mimeApps = {
      enable = true;
      defaultApplications =
        let
          browser = [ "google-chrome.desktop" ];
        in
        {
          "application/json" = browser;
          "application/pdf" = browser;

          "text/html" = browser;
          "text/xml" = browser;
          "application/xml" = browser;
          "application/xhtml+xml" = browser;
          "application/xhtml_xml" = browser;
          "application/rdf+xml" = browser;
          "application/rss+xml" = browser;
          "application/x-extension-htm" = browser;
          "application/x-extension-html" = browser;
          "application/x-extension-shtml" = browser;
          "application/x-extension-xht" = browser;
          "application/x-extension-xhtml" = browser;

          "x-scheme-handler/about" = browser;
          "x-scheme-handler/ftp" = browser;
          "x-scheme-handler/http" = browser;
          "x-scheme-handler/https" = browser;
          "x-scheme-handler/unknown" = browser;

          "x-scheme-handler/discord" = [ "discord.desktop" ];
          "x-scheme-handler/slack" = [ "slack.desktop" ];

          "audio/*" = [ "mpv.desktop" ];
          "video/*" = [ "mpv.dekstop" ];
          "image/*" = [ "imv.desktop" ];
        };
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_DESKTOP_DIR="$HOME/desktop";
        XDG_DOCUMENTS_DIR="$HOME/documents";
        XDG_DOWNLOAD_DIR="$HOME/downloads";
        XDG_MUSIC_DIR="$HOME/music";
        XDG_PICTURES_DIR="$HOME/pictures";
        XDG_PUBLICSHARE_DIR="$HOME/public";
        XDG_TEMPLATES_DIR="$HOME/templates";
        XDG_VIDEOS_DIR="$HOME/videos";
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/screenshots";
      };
    };
  };

  home.persistence = {
    "/home/dsod".directories = [
      config.xdg.userDirs.desktop
      config.xdg.userDirs.documents
      config.xdg.userDirs.downloads
      config.xdg.userDirs.music
      config.xdg.userDirs.pictures
      config.xdg.userDirs.public
      config.xdg.userDirs.templates
      config.xdg.userDirs.videos
      config.xdg.userDirs.screenshots
      "$HOME/.local/bin"
      ];
  };
}