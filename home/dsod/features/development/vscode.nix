{ pkgs, config, ... }:

{
  programs.vscode = {
    enable = true;
  };

  home.sessionVariables = { 
    EDITOR = "vscode"; 
  };
}
