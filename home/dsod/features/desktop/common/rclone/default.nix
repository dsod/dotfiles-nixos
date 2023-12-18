{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    rclone
  ];

  home.sessionVariables = {
    RCLONE_PASSWORD_COMMAND = "pass rclone/config/password";
  };

  xdg.configFile."rclone/rclone.conf".source = config.lib.file.mkOutOfStoreSymlink /home/dsod/dotfiles/home/dsod/features/desktop/common/rclone/config.conf;
}

