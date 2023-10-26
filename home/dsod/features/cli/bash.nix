{
  programs.bash = {
    enable = true;
    shellAliases = {
      sudo = "sudo TERMINFO=\"$TERMINFO\"";
    };
  };
}
