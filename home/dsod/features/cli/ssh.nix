{ outputs, lib, ... }:
let
  hostnames = builtins.attrNames outputs.nixosConfigurations;
in
{
  programs.ssh = {
    enable = true;
  };

  home.persistence = {
    "/home/dsod".directories = [ ".ssh" ];
  };
}
