{ lib
, pkgs
, stdenv
, fetchFromGitHub
, makeWrapper
, pass
, jq
, bitwarden-cli
, libnotify
, wl-clipboard
, coreutils
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
          pass
          jq
          bitwarden-cli
          libnotify
          wl-clipboard
          coreutils
        ]
      }"
  '';

  meta = {
    description = "A rofi graphical menu for bitwarden cli";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
