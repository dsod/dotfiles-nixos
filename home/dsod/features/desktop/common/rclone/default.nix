{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    rclone
  ];

  home.sessionVariables = {
    RCLONE_PASSWORD_COMMAND = "pass rclone/config/password";
  };

  home.file."dotfiles/home/dsod/features/desktop/common/rclone/config.conf".source = config.lib.file.mkOutOfStoreSymlink /home/dsod/.config/rclone/rclone.conf;
}

