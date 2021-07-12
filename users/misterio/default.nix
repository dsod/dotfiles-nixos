{ pkgs, ... }:

let hashed_password = import ./password.nix;
in {
  users = {
    mutableUsers = false;
    users.misterio = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" ];
      shell = pkgs.zsh;
      initialHashedPassword = "${hashed_password}";
    };
  };

  imports = [
    ../../imports/home-manager/nixos
  ];

  security.pam.services.swaylock = {};
  services.getty.autologinUser = "misterio";
  home-manager.useUserPackages = true;
  home-manager.users.misterio = {
    imports = [
      ../../imports/impermanence/home-manager.nix
      ./../../modules/colorscheme.nix
      ./../../modules/wallpaper.nix
      ./modules/alacritty.nix
      ./modules/direnv.nix
      ./modules/fzf.nix
      ./modules/git.nix
      ./modules/gpg-agent.nix
      ./modules/gtk.nix
      ./modules/rgbdaemon.nix
      ./modules/neofetch.nix
      ./modules/nvim.nix
      ./modules/pass.nix
      ./modules/qutebrowser.nix
      ./modules/starship.nix
      ./modules/sway.nix
      ./modules/waybar.nix
      ./modules/zathura.nix
      ./modules/zsh.nix
    ];

    wallpaper.generate = true;
    #wallpaper.path = "/dotfiles/assets/Wallpapers/astronaut-minimalism.png";
    colorscheme = import ./current-scheme.nix;

    nixpkgs.config.allowUnfree = true;

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      bottom
      discord
      dragon-drop
      fira
      fira-code
      glib
      gsettings-desktop-schemas
      imv
      pinentry-gnome
      spotify
      steam
      lutris
      xdg-utils
    ];

    # Scripts
    home.file = { "bin".source = "/dotfiles/scripts"; };

    # Writable (persistent) data
    home.persistence."/data" = {
      directories = [
        "Documents"
        "Downloads"
        "Games"
        "Pictures"
        ".gnupg"
        ".config/Hero_Siege"
        ".local/share/Steam"
        ".local/share/Tabletop Simulator"
        ".local/share/password-store"
      ];
      allowOther = false;
    };
  };
}
