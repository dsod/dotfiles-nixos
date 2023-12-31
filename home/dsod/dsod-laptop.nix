{ inputs, config, outputs, lib, pkgs, ... }: {
  imports = [
    (import ./global (
      {
        inherit inputs outputs lib pkgs config;
        qbankPath = "${config.home.homeDirectory}/dev";
      }
    ))
    ./features/desktop/hyprland
  ];

  colorscheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;

  home.sessionVariables = {
    "NIXOS_OZONE_WL" = "1";
    "XCURSOR_THEME" = "Catppuccin-Macchiato-Dark-Cursors";
    "LIBVA_DRIVER_NAME" = "nvidia";
    "XDG_SESSION_TYPE" = "wayland";
    "GBM_BACKEND" = "nvidia-drm";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    "WLR_NO_HARDWARE_CURSORS" = "1";
    "WLR_EGL_NO_MODIFIRES" = "1";
    "WLR_DRM_NO_ATOMIC" = "1";
    "WLR_RENDERER" = "vulkan";
  };

  xresources.properties = {
    "Xft.dpi" = 86;
  };

  monitors = [ ];

}
