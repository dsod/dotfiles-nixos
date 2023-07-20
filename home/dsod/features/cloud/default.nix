{ pkgs, lib, outputs, ... }:
{
  imports = [
    ./google-cloud-sdk.nix
    ./aws-cli.nix
  ];
}
