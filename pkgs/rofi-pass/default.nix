{ lib
, pkgs
, stdenv
, fetchFromGitHub
, makeWrapper
, pass
, jq
, rofi
, libnotify
, wl-clipboard
, findutils
, gnused
, coreutils
}:

with lib;

stdenv.mkDerivation {
  name = "rofi-pass";
  version = "1.0";
  src = ./rofi-pass.sh;

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;
  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    install -Dm 0755 $src $out/bin/rofi-pass
    wrapProgram $out/bin/rofi-pass --set PATH \
      "${
        makeBinPath [
          pass
          jq
          rofi
          libnotify
          wl-clipboard
          findutils
          gnused
          coreutils
        ]
      }"
  '';

  meta = {
    description = "A wofi graphical menu for pass";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
