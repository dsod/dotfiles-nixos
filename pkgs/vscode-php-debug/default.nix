{ lib
, fetchFromGitHub
, buildNpmPackage
, pkgs
}:

with lib;
buildNpmPackage rec {
  pname = "vscode-php-debug";
  version = "1.33.1";
  src = fetchFromGitHub {
    owner = "xdebug";
    repo = pname;
    rev = "refs/tags/v${version}";
    sha256 = "sha256-De4AiB9MeoPGIkN149ZnEF0EVLwsVhU9o8WkxUaUZoc=";
  };

  nativeBuildDeps = [ pkgs.python38 ];
  npmDepsHash = "sha256-nQQQM1btVRf7QFtXoxAY6XiRmxliHjv0HuqRMhtqPpA=";

  dontNpmBuild = true;

  meta = {
    description = "Microsoft PHP DAP debugger";
    homepage = "https://github.com/xdebug/vscode-php-debug";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
