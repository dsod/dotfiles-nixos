{ pkgs, inputs, config, ... }: {
  imports = [
   inputs.hardware.nixosModules.common-cpu-intel
   #inputs.hardware.nixosModules.common-gpu-nvidia
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

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.kernelModules = [  "coretemp" ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];
  #boot.blacklistedKernelModules = [ "i915" ];
  #boot.kernelParams = [ "nvidia_drm.modeset=1" "ibt=off" ];

  programs.light.enable = true;

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

  services.thermald.enable = true;
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

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

# hardware.nvidia = {
#   modesetting.enable = true;
#   powerManagement.enable = false;
#  powerManagement.finegrained = false;
#    open = false;
#    nvidiaSettings = true;
#    prime = {
#     offload.enable = false;
#	    sync.enable = false;
 #     # intelBusId = "PCI:0:2:0";
#		  # nvidiaBusId = "PCI:1:0:0";
 #  };
  #};

 # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

  system.stateVersion = "23.05";
}
