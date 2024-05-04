{ mkYarnPackage
, fetchFromGitHub
, fetchYarnDeps
, lib
}:

mkYarnPackage rec {
  pname = "jscpd";
  version = "3.5.10";

  src = fetchFromGitHub {
    owner = "kucherenko";
    repo = "jscpd";
    rev = "v${version}";
    hash = "sha256-3bYyOFPrr3ptZVPoyHcC2VuAiY/iZp3rgTX+CkA1AJQ";
  };

  #packageJSON = ./package.json;

  offlineCache = fetchYarnDeps {
    yarnLock = "${src}/yarn.lock";
    hash = "sha256-YQCVAoJkgLHeor4PRR9LlHyp/3piGYBK7FpW1VqIjGg";
  };

  checkPhase = ''
    yarn test
  '';

  installPhase = ''
  '';

  meta = {
    description = "Copy/paste detector for programming source code.";
    mainProgram = "jscpd";
    homepage = "https://github.com/kucherenko/jscpd";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ strager ];
    platforms = lib.platforms.all;
  };
}
