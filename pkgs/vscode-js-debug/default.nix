{ lib
, fetchFromGitHub
, buildNpmPackage
}:

with lib;
buildNpmPackage rec {
  pname = "vscode-js-debug";
  version = "1.84.0";
  src = fetchFromGitHub {
    owner = "microsoft";
    repo = pname;
    rev = "refs/tags/v${version}";
    sha256 = "sha256-qDpaRjj32K9RZPVlZ8+zaVVx5BAyPAjcwfp0uyHJctY=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-yxSVoTqxAzuihsGVh6+7lby0FwdHiCq8CaGfc5ZroiE=";

  meta = {
    description = "Microsoft Javascript DAP debugger";
    homepage = "https://github.com/microsoft/vscode-js-debug";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
