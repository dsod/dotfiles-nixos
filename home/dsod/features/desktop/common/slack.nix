{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [ slack ];

  home.persistence = {
    "/home/dsod".directories = [ ".config/slack" ];
  };
}
