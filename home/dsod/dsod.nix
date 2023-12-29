{ inputs, config, outputs, lib, pkgs, ... }: {
  imports = [
    (import ./global (
      {
        inherit inputs outputs lib pkgs config;
        qbankPath = "${config.home.homeDirectory}/dev/qbank";
      }
    ))
    ./features/desktop/hyprland
  ];

  colorscheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;

  home.sessionVariables = {
    "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
    "XDG_SESSION_TYPE" = "wayland";
    "XCURSOR_THEME" = "Catppuccin-Macchiato-Dark-Cursors";
    "WLR_DRM_NO_ATOMIC" = "1";
  };

  xresources.properties = {
    "Xft.dpi" = 86;
  };

  monitors = [
    {
      name = "DP-1";
      width = 2560;
      height = 1440;
      refreshRate = 144;
      x = 0;
      workspace = "1";
    }
  ];
}
