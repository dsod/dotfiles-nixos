{config, lib, pkgs, modulesPath, ...}:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "ahci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];

    };
    kernelModules = [ "amdgpu" "kvm-amd" ];
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
  };


  fileSystems."/" =
    { device = "/dev/disk/by-uuid/bbc6fa61-4d9d-449f-b1c0-48552423c5b3";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-c89a3cd1-42fc-4eb8-8b77-bca459ed5801".device = "/dev/disk/by-uuid/c89a3cd1-42fc-4eb8-8b77-bca459ed5801";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/A9A0-A4BE";
      fsType = "vfat";
    };

  swapDevices =
    [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp38s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
