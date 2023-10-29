{...}: {
  fonts = {
      enableDefaultPackages = true;
      fontconfig.defaultFonts = {
        monospace = [ "UbuntuMono Nerd Font" ];
        sansSerif = [ "Ubuntu Nerd Font" "Open Sans" ];
        serif = [ "Ubuntu Nerd Font" "Open Sans" ];
      };
  };
}
