{ stdenv, fetchFromGitHub, buildDunePackage, cstruct, core, ppx_deriving }:

buildDunePackage rec {
  pname = "hack_parallel";
  version = "0.1.1";

  minimumOCamlVersion = "4.02"; # @@@

  src = fetchFromGitHub {
    owner = "rvantonder";
    repo = "hack-parallel";
    rev = "v${version}";
    sha256 = "051hbnj4lvvfdb3vs14apl7kwpdn9rbalnllfdc4xnhv3rzzxsyk";
  };

  preBuild = "make libhp.a";
  buildInputs = [ core ppx_deriving ];
  #propagatedBuildInputs = [ ];

  meta = {
    description = "Parallel and shared memory components used in Facebook's Hack, Flow, and Pyre projects";
    #license = stdenv.lib.licenses.isc; @@@
    #maintainers = [ stdenv.lib.maintainers.vbgl ]; @@@
    #inherit (src.meta) homepage; @@@
  };
}
