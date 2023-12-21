{ pkgs, inputs, config, ... }: {
  imports = [
    inputs.hardware.nixosModules.dell-xps-15-9500-nvidia

    ./hardware-configuration.nix

    ../common/global
    ../common/users/dsod

    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix
    ../common/optional/wireless.nix
    ../common/optional/bluetooth.nix
    ../common/optional/thunar.nix
    ../common/optional/docker.nix
    ../common/optional/nix-ld.nix
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.kernelModules = [ "coretemp" ];
  boot.kernelParams = [ "acpi_rev_override=1" ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "dsod-laptop";
    extraHosts = ''
      127.0.0.1 localhost minio qbank-dev.localhost
      ::1 localhost minio qbank-dev.localhost
    '';
    firewall.allowedTCPPorts = [
      9003 # XDebug
    ];
  };

  environment.etc."sysconfig/lm_sensors".text = ''
    HWMON_MODULES="coretemp"
  '';

  programs = {
    dconf.enable = true;
    light.enable = true;
  };

  # Printer
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ brlaser brgenml1lpr brgenml1cupswrapper ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.inputs.hyprland.xdg-desktop-portal-hyprland ];
    configPackages = [ pkgs.inputs.hyprland.hyprland ];
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  system.stateVersion = "23.11";
}
