{ lib
, pkgs
, stdenv
, makeWrapper
, pass
, bitwarden-cli
, jq
, libnotify
, wl-clipboard
, coreutils
, findutils
, gnugrep
, rofi
, gawk
}:

with lib;

stdenv.mkDerivation {
  name = "rofi-bw";
  version = "1.0";
  src = ./rofi-bw.sh;

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;
  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    install -Dm 0755 $src $out/bin/rofi-bw
    wrapProgram $out/bin/rofi-bw --set PATH \
      "${
        makeBinPath [
          jq
          pass
          bitwarden-cli
          rofi
          findutils
          libnotify
          wl-clipboard
          coreutils
          gnugrep
          gawk
        ]
      }"
  '';

  meta = {
    description = "A rofi graphical menu for bitwarden cli";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
