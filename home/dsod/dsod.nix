{ inputs, ... }: {
  imports = [
    ./global
    ./features/desktop/hyprland
    ./features/productivity
    ./features/pass
    ./features/music
  ];

  colorscheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;

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
