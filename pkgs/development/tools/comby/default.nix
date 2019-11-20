{ lib, fetchFromGitHub, ocamlPackages }:

ocamlPackages.buildDunePackage rec {
  pname = "comby";
  version = "0.11.0";
  #version = "0.9.1";

  minimumOCamlVersion = "4.08.1";

  src = fetchFromGitHub {
    owner = "comby-tools";
    repo = pname;
    rev = version;
    #sha256 = "01kc07zp2xbzbzcmx7znvywg6bcr69sl5nia5bmadlmmbp9yhyiw"; # 0.11.1
    sha256 = "02r4h94myv54savz0r8rsx2y76p2237ja7s4g1nryp7vg4mm7q2b"; # 0.11.0
    #sha256 = "1sd7bjy4432bh7xxzcd6g304r9smgg1l8pwv6c93fn4asjfsg1p0"; # 0.8.0
    #sha256 = "1pb3i05smsxx5sy6m41hginrif2cnv1nsals7m0x7amyf1sm774r";
  };

  patches = [ ./ppx-conditional.patch ./equality.patch ./lwt-unix.patch ./missing-dependency.patch ];
  #patches = [ ./ppx-conditional-0.9.1.patch ];

  buildInputs = with ocamlPackages; [
    angstrom
    bisect_ppx
    camlzip
    core
    hack_parallel
    janeStreet.shell
    lambdaTerm # @@@ is this really necessary?
    lwt_react
    mparser-comby
    ocaml_lwt
    ocaml_oasis
    ocaml_pcre
    opium
    patdiff
    ppx_deriving
    ppx_deriving_yojson
    ppx_tools_versioned
    ppxlib
    tls
  ];
}
