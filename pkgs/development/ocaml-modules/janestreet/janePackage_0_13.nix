{ lib, fetchFromGitHub, buildDunePackage, defaultVersion ? "0.13" }:

{ pname, version ? defaultVersion, hash, ...}@args:

buildDunePackage (args // {
  inherit version;

  minimumOCamlVersion = "4.07";

  src = fetchFromGitHub {
    owner = "janestreet";
    repo = pname;
    rev = "v${version}";
    sha256 = hash;
  };

  meta.license = lib.licenses.mit;
  meta.homepage = "https://github.com/janestreet/${pname}";
})
