{ pkgs, persistence, lib, ... }: {
  programs.mangohud.enable = true;
  home.packages = with pkgs; [ steam ];

  home.persistence = lib.mkIf persistence {
    "/data/games/misterio" = {
      allowOther = true;
      directories = [
        "Games/Steam"
        ".local/share/Steam"

        ".factorio"
        ".config/Hero_Siege"
        ".config/unity3d/Berserk Games/Tabletop Simulator"
        ".config/unity3d/IronGate/Valheim"
        ".local/share/Tabletop Simulator"
        ".local/share/Paradox Interactive"
        ".paradoxlauncher"
      ];
      files = [ ".steam/steam.token" ".steam/registry.vdf" ];
    };
  };
}