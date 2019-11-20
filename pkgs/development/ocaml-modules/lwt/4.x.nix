{ lib, fetchFromGitHub, pkgconfig, ncurses, libev, buildDunePackage, ocaml
, cppo, ocaml-migrate-parsetree, ppx_tools_versioned, result
, bisect_ppx
, mmap, seq
}:

let inherit (lib) optional versionAtLeast; in

buildDunePackage rec {
  pname = "lwt";
  version = "4.2.1";

  src = fetchFromGitHub {
    owner = "ocsigen";
    repo = pname;
    rev = version;
    sha256 = "1hz24fyhpm7d6603v399pgxvdl236srwagqja41ljvjx83y10ysr";
  };

#  src = fetchFromGitHub {
#    owner = "rvantonder";
#    repo = pname;
#    rev = "1d58b7993961d4a1f668ffbae94450145dd30677";
#    sha256 = "0mmkvglc805rmvgwciwng3fqsa69gl0zmp590k1nrs1vjmhzzfsd";
#  };

#  postPatch = ''
#    substituteInPlace lwt.opam \
#    --replace 'version: "dev"' 'version: "${version}"'
#  '';

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ cppo ocaml-migrate-parsetree ppx_tools_versioned ]
   ++ optional (!versionAtLeast ocaml.version "4.07") ncurses;
  propagatedBuildInputs = [ libev mmap seq result ];

  meta = {
    homepage = "https://ocsigen.org/lwt/";
    description = "A cooperative threads library for OCaml";
    maintainers = [ lib.maintainers.vbgl ];
    license = lib.licenses.mit;
  };
}
