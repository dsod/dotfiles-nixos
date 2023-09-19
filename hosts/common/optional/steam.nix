{pkgs, config, ...}:
let
  proton-ge-custom = pkgs.proton-ge-custom.override {};
in
{
  environment.systemPackages = with pkgs; [
    proton-ge-custom
    gamemode
    mangohud
  ];

  environment.variables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${pkgs.proton-ge-custom}";

  programs.steam = {
    enable = true;
  };
}
