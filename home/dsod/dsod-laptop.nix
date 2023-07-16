{ inputs, ... }: {
  imports = [
    ./global
    ./features/desktop/hyprland
    ./features/productivity
    ./features/pass
    ./features/music
  ];

  colorscheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
  monitors = [];

}
