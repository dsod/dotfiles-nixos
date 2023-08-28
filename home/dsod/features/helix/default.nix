{ config, pkgs, ... }:
let
  inherit (config) colorscheme;
in
{
    home.sessionVariables = { 
      COLORTERM = "truecolor"; 
    };
    
    home.packages = with pkgs; [
      nodePackages.intelephense
      nodePackages.typescript-language-server
    ];
    programs.helix = {
    enable = true;
    settings = {
      theme = colorscheme.slug;
      editor = {
        color-modes = true;
        line-number = "relative";
        indent-guides.render = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        bufferline = "always";
      };
    };
    themes = import ./theme.nix { inherit colorscheme; };
    languages = {
      language = [
        {
          name = "php";
          file-types = ["php" "inc" "tpl"];
          config = {
            licenceKey = "00HAMU0OFBGZNXO";
          };
        }
      ];
    };
  };
}
