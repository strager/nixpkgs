{
  stdenv,
  doxygen,
  fetchurl,
  fetchFromGitHub,
  python2Packages,
  thrift-py2
}:

python2Packages.buildPythonApplication rec {
  format = "other";

  version = "6.10.0";
  pname = "codechecker";

  srcs = [
    (fetchFromGitHub {
      owner = "Ericsson";
      repo = pname;
      rev = "v${version}";
      sha256 = "0q0q0h6ad6xcjkq3c7f2q0cv71nxvsv07pni0fv97ykc33z2lj3l";
    })
  ];
  patches = [ ./disable-lint.patch ];

  codeMirrorMinifiedJS = fetchurl {
    url = https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.30.0/codemirror.min.js;
    sha256 = "05a5l1gja9rfbf9fhiyjrks1lqdvn00ybs0h984sp4sarz0wra82";
  };
  codeMirrorMinifiedCSS = fetchurl {
    url = https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.30.0/codemirror.min.css;
    sha256 = "0nbgvyxi5f56wqwfvsj4prsz1329ag3rj29dlp4qm7hw1vzqwny2";
  };
  codeMirrorLicense = fetchurl {
    # @@@ we should use a specific version, not master
    url = https://raw.githubusercontent.com/codemirror/CodeMirror/master/LICENSE;
    sha256 = "1gskvlpw1jnjskk5x0vk7a8dr6q4vn1x5i9pqy0alwdlqqmgxwm3";
  };
  clikeMinifiedJS = fetchurl {
    url = https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.30.0/mode/clike/clike.min.js;
    sha256 = "0gn737mbsygid6shg2llql67311vr698zac1n8wavfw2pdmyd5ll";
  };
  codeMirrorSrc = fetchFromGitHub {
    owner = "codemirror";
    repo = "CodeMirror";
    rev = "5.25.0";
    sha256 = "0d3m60ra1ylhbrgz7qlr3byvk4rpipj5wm302rn0bi5zxla90rls";
  };
  highlightjsMinifiedJS = fetchurl {
    url = http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.0.0/highlight.min.js;
    sha256 = "1a1qj7ymg8d6iq8j6l3sqhvjqp5yh4f1mlzi3hww7qir9s20i324";
  };
  highlightjsXcodeMinifiedCSS = fetchurl {
    url = http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.0.0/styles/xcode.min.css;
    sha256 = "19nik2r4yn0zwa1pskqjh47w2xzvblsxga2pal64fywxd8dgnh1q";
  };
  markedSrc = fetchFromGitHub {
    owner = "chjj";
    repo = "marked";
    rev = "v0.3.3";
    sha256 = "1dgcdfn9zdb9nscc4vjfldz7qlmpmiw2hqg52kcb3dq4x8dprabc";
  };
  jsPlumbSrc = fetchFromGitHub {
    owner = "sporritt";
    repo = "jsPlumb";
    rev = "2.2.0";
    sha256 = "0j7m73n20qxn7srffg3ikmq36b6mxr6rckkxcl0x1ga3qadhz9gz";
  };
  jqueryMinifiedJS = fetchurl {
    url = https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js;
    sha256 = "1gyrxy9219l11mn8c6538hnh3gr6idmimm7wv37183c0m1hnfmc5";
  };
  dojo = fetchurl {
    url = https://download.dojotoolkit.org/release-1.10.4/dojo-release-1.10.4.tar.gz;
    sha256 = "1waiyn1bbbvb0mrd850m6hgpbk22qc1dywb8xs7vbi8fj8dhams0";
  };

  postUnpack = ''
    set -x # @@@
    pwd

    mkdir -p source/tools/plist_to_html/plist_to_html/static/vendor/codemirror
    cp ${codeMirrorMinifiedJS} source/tools/plist_to_html/plist_to_html/static/vendor/codemirror/codemirror.min.js
    cp ${codeMirrorMinifiedCSS} source/tools/plist_to_html/plist_to_html/static/vendor/codemirror/codemirror.min.css
    cp ${codeMirrorLicense} source/tools/plist_to_html/plist_to_html/static/vendor/codemirror/codemirror.LICENSE
    cp ${clikeMinifiedJS} source/tools/plist_to_html/plist_to_html/static/vendor/codemirror/clike.min.js

    mkdir -p source/web/server/vendor/codemirror/dist
    cp ${codeMirrorMinifiedJS} source/web/server/vendor/codemirror/dist/codemirror.min.js

    mkdir -p source/web/server/vendor/highlightjs
    cp ${highlightjsMinifiedJS} source/web/server/vendor/highlightjs/highlight.min.js

    mkdir -p source/web/server/vendor/highlightjs/css
    cp ${highlightjsXcodeMinifiedCSS} source/web/server/vendor/highlightjs/css/xcode.min.css

    mkdir -p source/web/server/vendor/jquery
    cp ${jqueryMinifiedJS} source/web/server/vendor/jquery/jquery-3.1.1-min.js

    mkdir -p source/web/server/vendor
    (
      mkdir unpack-tmp # @@@ use /tmp?
      cd unpack-tmp
      unpackFile ${codeMirrorSrc}
      chmod -R u+w .
      # @@@ this is fragile. what if the destination exists?
      mv * ../source/web/server/vendor/codemirror
      cd ..
      rmdir unpack-tmp
    )

    # @@@ factor
    mkdir -p source/web/server/vendor
    (
      mkdir unpack-tmp # @@@ use /tmp?
      cd unpack-tmp
      unpackFile ${markedSrc}
      chmod -R u+w .
      # @@@ this is fragile. what if the destination exists?
      mv * ../source/web/server/vendor/marked
      cd ..
      rmdir unpack-tmp
    )

    # @@@ factor
    mkdir -p source/web/server/vendor
    (
      mkdir unpack-tmp # @@@ use /tmp?
      cd unpack-tmp
      unpackFile ${jsPlumbSrc}
      chmod -R u+w .
      # @@@ this is fragile. what if the destination exists?
      mv * ../source/web/server/vendor/jsplumb
      cd ..
      rmdir unpack-tmp
    )

    # @@@ does Nix have a helper for this?
    mkdir -p source/web/server/vendor
    tar xf ${thrift-py2.src} -C source/web/server/vendor
    # @@@ this is fragile. what if the destination exists?
    # what if the exacted directory isn't named thrift-*?
    # what if there's more than one glob match?
    mv source/web/server/vendor/thrift-* source/web/server/vendor/thrift

    mkdir -p source/web/server/vendor/dojotoolkit
    # @@@ build from source?
    tar xf ${dojo} -C source/web/server/vendor/dojotoolkit

    set +x # @@@
  '';

  nativeBuildInputs = [
    doxygen
    thrift-py2
  ];
  propagatedBuildInputs = [
    # See analyzer/requirements_py/osx/requirements.txt.
    python2Packages.lxml
    python2Packages.portalocker
    python2Packages.psutil
    #python2Packages.scan-build # @@@
    # See web/requirements_py/osx/requirements.txt.
    python2Packages.alembic
    python2Packages.lxml
    python2Packages.portalocker
    python2Packages.psutil
    python2Packages.sqlalchemy
    #python2Packages.thrift
    thrift-py2
  ];
  pythonPath = propagatedBuildInputs; # @@@ I'm pretty sure this is wrong.

  build = "make package";

  doCheck = true;
  checkInputs = [ python2Packages.nose ];
  installCheckPhase = ''
    patchPythonScript "$PWD/build/CodeChecker/cc_bin/CodeChecker.py"
    wrapPythonProgramsIn "$PWD/build/CodeChecker/bin" "$out $pythonPath"
    make test # @@@ tests fail. feelsbadman
  '';

  installPhase = ''
    echo '@@@ env python'
    declare | grep -i portalocker

    mkdir $out
    # @@@ doesn't follow standard directory structure...
    mv build/CodeChecker $out/CodeChecker
  '';

  meta = with stdenv.lib; {
    description = "Static analysis infrastructure built on the LLVM/Clang Static Analyzer";
    longDescription = ''
      CodeChecker is a static analysis infrastructure built on the LLVM/Clang Static Analyzer toolchain, replacing scan-build in a Linux or macOS (OS X) development environment.

      CodeChecker is an analyzer tooling, defect database and viewer extension for the Clang Static Analyzer and Clang Tidy.
    '';
    homepage = https://codechecker.readthedocs.io/;
    #license = licenses.lgpl21; # @@@
    #maintainers = with maintainers; [ pSub ]; # @@@
    #platforms = jre.meta.platforms; # @@@
  };
}
