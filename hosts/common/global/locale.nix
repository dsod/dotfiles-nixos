{ lib, ... }: {
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = lib.mkDefault "sv_SE.UTF-8";
      LC_IDENTIFICATION = lib.mkDefault "sv_SE.UTF-8";
      LC_MEASUREMENT = lib.mkDefault "sv_SE.UTF-8";
      LC_MONETARY = lib.mkDefault "sv_SE.UTF-8";
      LC_NAME = lib.mkDefault "sv_SE.UTF-8";
      LC_NUMERIC = lib.mkDefault "sv_SE.UTF-8";
      LC_PAPER = lib.mkDefault "sv_SE.UTF-8";
      LC_TELEPHONE = lib.mkDefault "sv_SE.UTF-8";
      LC_TIME = lib.mkDefault "sv_SE.UTF-8";
    };
    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
      "sv_SE.UTF-8/UTF-8"
    ];
  };
  time.timeZone = lib.mkDefault "Europe/Stockholm";
}
