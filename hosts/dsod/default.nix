{ pkgs, inputs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/dsod

    ../common/optional/pipewire.nix
    ../common/optional/wireless.nix
    ../common/optional/bluetooth.nix
    ../common/optional/thunar.nix
    ../common/optional/docker.nix
    ../common/optional/steam.nix
  ];

  networking = {
    hostName = "dsod";
    extraHosts = ''
      127.0.0.1   qbank3-dev qbank3-dev.localhost minio mediaportals.localhost
      ::1   qbank3-dev qbank3-dev.localhost minio mediaportals.localhost
    '';
    firewall = {
      enable = true;
      allowedTCPPorts = [
        9003 # XDebug
      ];
    };
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];
  };

  programs = {
    dconf.enable = true;
  };


  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [ mesa ];
      driSupport = true;
      driSupport32Bit = true;
    };
    opentabletdriver.enable = true;
  };

  environment.variables.AMD_VULKAN_ICD = "RADV";

  security.polkit.enable = true;

  system.stateVersion = "23.05";
}
