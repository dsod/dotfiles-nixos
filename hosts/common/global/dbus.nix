{pkgs, ...}: {
  services.dbus = {
    enable = true;
    packages = with pkgs; [gnome.gnome-keyring];
  };
}
