{pkgs, ...}: {
  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" ];
  };

  home.packages = with pkgs; [
    gnome.seahorse
  ];
}
