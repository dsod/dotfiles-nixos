{ inputs, lib, config, pkgs, osConfig, ... }:
let
  hyprlandExecCommand = if osConfig.hardware.nvidia.prime.offload.enable then "nvidia-offload Hyprland" else "Hyprland";
in
{
  imports = [
    ../common
    ../common/wayland-wm
    inputs.hyprland.homeManagerModules.default
  ];

  programs = {
    fish.loginShellInit = ''
      if test (tty) = "/dev/tty1"
        exec ${hyprlandExecCommand} &> /dev/null
      end
    '';
    zsh.loginExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec ${hyprlandExecCommand} &> /dev/null
      fi
    '';
    zsh.profileExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec ${hyprlandExecCommand} &> /dev/null
      fi
    '';
  };

  home.packages = with pkgs; [
    inputs.hyprwm-contrib.packages.${system}.grimblast
    inputs.hyprwm-contrib.packages.${system}.scratchpad
    swayidle
    dconf
    openssl # Might be required by certain applications like Postman
  ];

  programs.waybar.package = pkgs.waybar.overrideAttrs (oa: {
    mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
  });

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    extraConfig =
      (import ./monitors.nix {
        inherit lib;
        inherit (config) monitors;
      }) +
      (import ./config.nix {
        inherit (config) home colorscheme;
      });
  };
}
