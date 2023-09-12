{ pkgs, inputs, config, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/dsod

    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix
    ../common/optional/wireless.nix
    ../common/optional/bluetooth.nix
    ../common/optional/thunar.nix
    ../common/optional/docker.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];
  };

  programs.light.enable = true;

  networking = {
    hostName = "dsod-laptop";
    extraHosts = ''
      127.0.0.1 localhost qbank3-dev qbank3-dev.localhost minio mediaportals.localhost
      ::1 localhost qbank3-dev qbank3-dev.localhost minio mediaportals.localhost
      13.50.70.170 dam.camfil.com camfil-us-mediaportal.qbank.se
    '';
  };

  boot.kernelModules = [ "coretemp" ];
  services.thermald.enable = true;
  # services.xserver.videoDrivers = ["nvidia"]; Doesn't work yet :(
  environment.etc."sysconfig/lm_sensors".text = ''
    HWMON_MODULES="coretemp"
  '';

  programs = {
    dconf.enable = true;
  };

  # Printer
  services.printing.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  hardware = {
    nvidia = {
      prime.offload.enable = false;
      modesetting.enable = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  system.stateVersion = "23.05";
}
