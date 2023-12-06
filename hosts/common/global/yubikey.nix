{ pkgs, ... }: {
  # PIV / Yubikey smart card support
  services.pcscd.enable = true;
  services.udev =
    {
      packages = [ pkgs.yubikey-personalization ];
      enable = true;
    };

  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui
    yubico-piv-tool
  ];
}
