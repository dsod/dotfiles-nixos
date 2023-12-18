{ config, pkgs, ... }:
let
  browser = [ "google-chrome.desktop" ];
  documents = [ "org.pwmt.zathura.desktop" ];
  imageviewer = [ "imv.desktop" ];
in
{
  home.packages = with pkgs; [
    xdg-utils
  ];
  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";
    configFile."mimeapps.list".force = true;

    mimeApps = {
      enable = true;
      defaultApplications =
        {
          "application/json" = browser;
          "application/pdf" = documents;

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
          "image/jpg" = imageviewer;
          "image/jpeg" = imageviewer;
          "image/png" = imageviewer;
          "image/tiff" = imageviewer;
          "image/webp" = imageviewer;
          "image/avif" = imageviewer;
          "image/gif" = imageviewer;
          "image/x-tiff" = imageviewer;
          "image/svg" = imageviewer;
          "image/svg+xml" = imageviewer;
        };
      associations.added = {
        "application/json" = browser;
        "application/pdf" = documents;

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
        "image/jpg" = imageviewer;
        "image/jpeg" = imageviewer;
        "image/png" = imageviewer;
        "image/tiff" = imageviewer;
        "image/webp" = imageviewer;
        "image/avif" = imageviewer;
        "image/gif" = imageviewer;
        "image/x-tiff" = imageviewer;
        "image/svg" = imageviewer;
        "image/svg+xml" = imageviewer;
      };
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_DESKTOP_DIR = "$HOME/desktop";
        XDG_DOCUMENTS_DIR = "$HOME/documents";
        XDG_DOWNLOAD_DIR = "$HOME/downloads";
        XDG_MUSIC_DIR = "$HOME/music";
        XDG_PICTURES_DIR = "$HOME/pictures";
        XDG_PUBLICSHARE_DIR = "$HOME/public";
        XDG_TEMPLATES_DIR = "$HOME/templates";
        XDG_VIDEOS_DIR = "$HOME/videos";
        XDG_SCREENSHOTS_DIR = "$HOME/pictures/screenshots";
      };
    };
  };
  home.file."documents/encrypted/.keep".text = "";
  home.file."bruno/.keep".text = "";
  home.file."obsidian/.keep".text = "";
}
