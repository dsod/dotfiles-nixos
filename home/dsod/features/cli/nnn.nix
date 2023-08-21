{pkgs, config, ...}:
let 
    BLK="03";
    CHR="03";
    DIR="04";
    EXE = "02";
    REG = "07";
    HARDLINK = "05";
    SYMLINK = "05";
    MISSING = "08";
    ORPHAN = "01";
    FIFO = "06";
    SOCK = "03";
    UNKNOWN = "01";
  in
{
  home.sessionVariables = {
    NNN_FIFO = "${config.xdg.cacheHome}/nnn.fifo";
    NNN_COLORS = "#04020301;4231";
    NNN_FCOLORS = "${BLK}${CHR}${DIR}${EXE}${REG}${HARDLINK}${SYMLINK}${MISSING}${ORPHAN}${FIFO}${SOCK}${UNKNOWN}";
  };
  
  programs.nnn = {
    enable = true;
    package = pkgs.nnn.override {
      withNerdIcons = true;
    };
    bookmarks = {
      d = "~/documents";
      D = "~/downloads";
      p = "~/pictures";
      v = "~/videos";
      c = "~/cloud";
    };
    plugins = {
      src = (pkgs.fetchFromGitHub {
        owner = "jarun";
        repo = "nnn";
        rev = "v4.8";
        sha256 = "sha256-Hpc8YaJeAzJoEi7aJ6DntH2VLkoR6ToP6tPYn3llR7k=";
      }) + "/plugins";
      mappings = {
        c = "fzcd";
        f = "finder";
        p = "preview-tui";
      };
    };
  };
}