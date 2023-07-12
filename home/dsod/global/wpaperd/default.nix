{pkgs, config, ...}:
{
  home.packages = with pkgs; [
    wpaperd
  ];
  home.file.".config/wpaperd/wallpaper.toml".source = ./wallpaper.toml;

  home.file."${config.xdg.userDirs.pictures}/wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };
}
