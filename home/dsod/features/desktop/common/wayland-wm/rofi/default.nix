{pkgs, config, lib, ...}:
  let
    pass = config.programs.password-store.package;
    passEnabled = config.programs.password-store.enable;
    rofi-pass = pkgs.rofi-pass.override { inherit pass; };
    rofi-bw = pkgs.rofi-bw.override;
  in
{
  home.packages = with pkgs; [
    rofi-wayland
    rofi-bw
  ] ++ (lib.optional passEnabled rofi-pass);

  xdg.configFile."rofi/config" = {
    source = ./config;
    recursive = true;
  };

  xdg.configFile."rofi/bin" = {
    source = ./bin;
    recursive = true;
  };

  xdg.dataFile."rofi/themes" = {
    source = ./themes;
    recursive = true;
  };
}
