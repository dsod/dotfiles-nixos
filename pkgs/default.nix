{ pkgs ? import <nixpkgs> { } }: rec {

  # Packages with an actual source
  shellcolord = pkgs.callPackage ./shellcolord { };
  trekscii = pkgs.callPackage ./trekscii { };
  speedtestpp = pkgs.callPackage ./speedtestpp { };
  lando = pkgs.callPackage ./lando { };
  tidal-dl = pkgs.python3Packages.callPackage ./tidal-dl { };
  sitespeedio = pkgs.callPackage ./sitespeedio { };

  # Personal scripts
  minicava = pkgs.callPackage ./minicava { };
  pass-wofi = pkgs.callPackage ./pass-wofi { };
  primary-xwayland = pkgs.callPackage ./primary-xwayland { };
  wl-mirror-pick = pkgs.callPackage ./wl-mirror-pick { };
  lyrics = pkgs.callPackage ./lyrics { };

  # My slightly customized plymouth theme, just makes the blue outline white
  plymouth-spinner-monochrome = pkgs.callPackage ./plymouth-spinner-monochrome { };
}
