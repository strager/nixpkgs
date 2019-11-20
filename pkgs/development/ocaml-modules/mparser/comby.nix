{ stdenv, fetchFromGitHub, ocaml_oasis, ocaml, findlib, ocamlbuild, ocaml_pcre }:

stdenv.mkDerivation {
  name = "ocaml${ocaml.version}-mparser-comby-1.2.3";
  src = fetchFromGitHub {
    owner = "comby-tools";
    repo = "mparser";
    rev = "8de1895f6f4e48e19280ec37f3ec29776363d411";
    sha256 = "1h09x5xw70wl0jiwyga7dbwl9bh4ai7dn91z9zyzyn5aqw3cgr62";
  };

  buildInputs = [ ocaml_oasis ocaml findlib ocamlbuild ocaml_pcre ];

  configurePhase = "oasis setup && ocaml setup.ml -configure --enable-pcre";
  buildPhase = "ocaml setup.ml -build";
  installPhase = "ocaml setup.ml -install";

  createFindlibDestdir = true;

  meta = {
    description = "A simple monadic parser combinator OCaml library";
    license = stdenv.lib.licenses.lgpl21Plus;
    homepage = https://github.com/cakeplus/mparser;
    maintainers = [ stdenv.lib.maintainers.vbgl ];
    inherit (ocaml.meta) platforms;
  };
}
