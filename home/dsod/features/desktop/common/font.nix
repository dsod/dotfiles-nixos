{ pkgs, ... }: {
  home.packages = with pkgs; [ open-sans ];

  fontProfiles = {
    enable = true;
    monospace = {
      family = "UbuntuMono Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "UbuntuMono" ]; };
    };
    regular = {
      family = "Ubuntu Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "Ubuntu" ]; };
    };
  };
}
