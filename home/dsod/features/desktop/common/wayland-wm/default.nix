{ pkgs, ... }:
{
  imports = [
    ./kitty.nix
    ./mako.nix
    ./swayidle.nix
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    grim
    primary-xwayland
    pulseaudio
    slurp
    wf-recorder
    wl-clipboard
    cliphist # Clipboard tool
    hyprpicker # Color pciker
    wl-mirror
    wl-mirror-pick
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
