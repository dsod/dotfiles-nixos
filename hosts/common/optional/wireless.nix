{ pkgs, config, lib, ... }: {
  networking.networkmanager = {
    enable = true;
    enableStrongSwan = true;
  };

  services.xl2tpd.enable = true;
  services.strongswan = {
    enable = true;
    secrets = [
      "ipsec.d/ipsec.nm-l2tp.secrets"
    ];
  };
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs; [
    at-spi2-atk
  ];
}
