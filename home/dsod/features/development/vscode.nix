{ pkgs, config, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  home.sessionVariables = {
    EDITOR = "code";
  };
}
