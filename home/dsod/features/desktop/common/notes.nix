{ pkgs, ... }: {
  home.packages = with pkgs; [
    obsidian
  ];
  home.file."documents/scratchpad/.keep".text = "";
}
