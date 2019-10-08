{
  fetchFromGitHub,
  python3Packages,
  stdenv
}:

python3Packages.buildPythonApplication rec {
  version = "2.0.17";
  pname = "scan-build";

  src = fetchFromGitHub {
    owner = "rizsotto";
    repo = pname;
    rev = version;
    sha256 = "120q7bna1fc2wd2b5kf6dsyh84kw9j5vld6n5c95rbjfkclkn43q";
  };

  # @@@ enable checking.
  # https://github.com/rizsotto/scan-build/blob/2.0.17/.travis.yml

  meta = with stdenv.lib; {
    description = "@@@";
    longDescription = ''
      @@@
    '';
    #homepage =  # @@@
    #license = licenses.lgpl21; # @@@
    #maintainers = with maintainers; [ pSub ]; # @@@
    #platforms = jre.meta.platforms; # @@@
  };
}

