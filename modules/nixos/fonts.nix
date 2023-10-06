{...}: {
  fonts = {
      enableDefaultPackages = true;
      fontconfig.defaultFonts = {
        monospace = [ "UbuntuMono Nerd Font" ];
        sansSerif = [ "Open Sans" ];
        serif = [ "Open Sans" ];
        # monospace = [ "UbuntuMono Nerd Font" ];
        # sansSerif = [ "Ubuntu Nerd Font" ];
        # serif = [ "Ubuntu Nerd Font" ];
      };
  };
}
