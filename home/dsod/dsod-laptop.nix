{ inputs, ... }: {
  imports = [
    ./global
    ./features/desktop/hyprland
  ];

  colorscheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
  icontheme = inputs.

systemd.user.sessionVariables = {
    "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
    "MOZ_ENABLE_WAYLAND" = "1"; # for firefox to run on wayland
    "MOZ_WEBRENDER" = "1";
    "XCURSOR_THEME" = "Catppuccin-Macchiato-Dark-Cursors";

    # for hyprland with nvidia gpu, ref https://wiki.hyprland.org/Nvidia/
"LIBVA_DRIVER_NAME" = "nvidia";
  "XDG_SESSION_TYPE" = "wayland";
 "GBM_BACKEND" = "nvidia-drm";
  "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
   "WLR_NO_HARDWARE_CURSORS" = "1";
   "WLR_EGL_NO_MODIFIRES" = "1";
  };

  xresources.properties = {
    "Xft.dpi" = 86;
  };

  monitors = [];

}
