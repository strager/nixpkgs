# @@@
{ stdenv, fetchFromGitHub, buildDunePackage, cstruct, ppx_deriving, core, core_kernel_p4, patience_diff, ppx_jane, dune, ocaml_pcre, re }:

buildDunePackage rec {
  pname = "patdiff";
  version = "0.13.0";

  minimumOCamlVersion = "4.02"; # @@@

  src = fetchFromGitHub {
    owner = "janestreet";
    repo = "patdiff";
    rev = "v${version}";
    sha256 = "1yqvxdmkgcwgx3npgncpdqwkpdxiqr1q41wci7589s8z7xi5nwyz";
  };

  buildInputs = [ core core_kernel_p4 patience_diff ppx_jane dune ocaml_pcre re ];
  #propagatedBuildInputs = [ ];

  meta = {
    #description = "Parallel and shared memory components used in Facebook's Hack, Flow, and Pyre projects"; @@@
    #license = stdenv.lib.licenses.isc; @@@
    #maintainers = [ stdenv.lib.maintainers.vbgl ]; @@@
    #inherit (src.meta) homepage; @@@
  };
}
