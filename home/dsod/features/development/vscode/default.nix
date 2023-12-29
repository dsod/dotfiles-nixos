{ pkgs, inputs, config, lib, ... }:
let
  extensions = inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
in
{
  programs.vscode = {
    enable = true;
    package = (pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: rec {
      src = (builtins.fetchTarball {
        url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
        sha256 = "017630xgr64qjva73imb56fcqr858xfcsbdgq97akawlxf1ydm5a";
      });
      version = "latest";

      buildInputs = oldAttrs.buildInputs ++ [ pkgs.krb5 ];
    });

    mutableExtensionsDir = true;

    extensions = with extensions; [
    ];
  };

  xdg.configFile."Code - Insiders/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink /home/dsod/dotfiles/home/dsod/features/development/vscode/settings.json;

  home.sessionVariables = {
    EDITOR = "code-insiders";
  };
}
