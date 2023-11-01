{pkgs, ...}: {
  home.packages = with pkgs; [
    dbeaver
    redisinsight
    jetbrains.datagrip
  ];
}
