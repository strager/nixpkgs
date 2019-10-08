{
  fetchFromGitHub,
  python3Packages,
  stdenv,
  lit
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

  patches = [ ./disable-macos-sip-check.patch ];

  doCheck = true;
  checkInputs = [ lit python3Packages.nose ];
  checkPhase = ''
    set -x

    # @@@
    mkdir tmp-clang-wrapper
    cat >tmp-clang-wrapper/clang <<'EOF'
#!/bin/sh
if [ "$1" = -cc1 ]; then
    exec /nix/store/nly8g8897vla6x4bhms7kfnc921w849l-clang-7.1.0/bin/clang "$@"
else
    exec /nix/store/nl1px9pl8j9kvjd8q12hdfdi02jqlaai-clang-wrapper-7.1.0/bin/clang "$@"
fi
EOF
    chmod +x tmp-clang-wrapper/clang
    PATH="$PWD/tmp-clang-wrapper:$PATH"

    wrapPythonProgramsIn "$PWD/tests/functional/bin" "$out $pythonPath"

    nosetests tests/unit
    lit -v tests
  '';

  meta = with stdenv.lib; {
    description = "Static code analyzer wrapper for Clang";
    longDescription = ''
    '';
    homepage = https://github.com/rizsotto/scan-build;
    
    #license = licenses.lgpl21; # @@@
    #maintainers = with maintainers; [ pSub ]; # @@@
    #platforms = jre.meta.platforms; # @@@
  };
}

