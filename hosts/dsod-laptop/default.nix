{ pkgs, inputs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/dsod

    ../common/optional/greetd.nix
    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix
    ../common/optional/wireless.nix
    
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    binfmt.emulatedSystems = [ "aarch64-linux" "i686-linux" ];
  };

  networking = {
    hostName = "dsod-laptop";
  };

  i18n.defaultLocale = "sv_SE.UTF-8";

  boot.kernelModules = [ "coretemp" ];
  services.thermald.enable = true;
  environment.etc."sysconfig/lm_sensors".text = ''
    HWMON_MODULES="coretemp"
  '';

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
