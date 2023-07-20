{  pkgs, ...}:
{
  programs.keychain = {
    enable = true;
    keys = [ "id_rsa" "id_ed25519" ];
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}
