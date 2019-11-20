{ lib, fetchFromGitHub, ocamlPackages }:

ocamlPackages.buildDunePackage rec {
  pname = "comby";
  version = "0.11.1";

  minimumOCamlVersion = "4.08.1";

  src = fetchFromGitHub {
    owner = "comby-tools";
    repo = pname;
    rev = version;
    sha256 = "01kc07zp2xbzbzcmx7znvywg6bcr69sl5nia5bmadlmmbp9yhyiw";
  };

  buildInputs = with ocamlPackages; [
    angstrom
    bisect_ppx
    camlzip
    core
    hack_parallel
    #lambda-term
    #lwt
    lwt_react
    mparser-comby
    #oasis
    opium
    #patdiff
    #pcre
    ppx_deriving
    ppx_deriving_yojson
    ppx_tools_versioned
    ppxlib
    tls
  ];
}
