{pkgs, ...}: {
  fonts = {
      enableDefaultFonts = true;
      fontconfig.defaultFonts = {
        monospace = [ "UbuntuMono Nerd Font" ];
        sansSerif = [ "Ubuntu Nerd Font" ];
        serif = [ "Ubuntu Nerd Font" ];
      };
  };
}
