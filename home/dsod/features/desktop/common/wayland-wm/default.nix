{ pkgs, ... }:
{
  imports = [
    ./kitty.nix
    ./mako.nix
    ./swayidle.nix
    ./swaylock.nix
    ./waybar.nix
    ./rofi
    ./zathura.nix
    ./remote-desktop.nix
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
    wtype # Typing values from Rofi launcher
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
