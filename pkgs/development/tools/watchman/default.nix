{ stdenv, lib, config, fetchFromGitHub, pcre,
  openssl,
  confFile ? config.watchman.confFile or null,
  withApple ? stdenv.isDarwin, CoreServices, CoreFoundation,
  cmake,
}:

stdenv.mkDerivation rec {
  name = "watchman-${version}";

  version = "4.9.4";

  src = fetchFromGitHub {
    owner = "facebook";
    repo = "watchman";
    rev = "fb7ac3df7031a531b1f74bc980cb8dd9a621363b";
    sha256 = "1iklfswg2qbp0bjgim66a44yygjg49i3n6dz1iap53d4fn3namgq";
  };
  patches = [
    ./conflicts.patch
    ./no-python.patch
    ./pcre.patch
    ./watchman-config-file-1.patch
    ./watchman-config-file-2.patch
    ./watchman-config-file.patch
    ./watchman-state-dir.patch
  ];

  buildInputs = [ pcre openssl ]
               ++ lib.optionals withApple [ CoreFoundation CoreServices ];
  nativeBuildInputs = [ cmake ];

  cmakeFlags = [
    "-DWATCHMAN_CONFIG_FILE:STRING="
    "-DWATCHMAN_STATE_DIR:STRING="
  ];

  prePatch = ''
    patchShebangs .
  '';

  meta = with lib; {
    description = "Watches files and takes action when they change";
    homepage    = https://facebook.github.io/watchman;
    maintainers = with maintainers; [ cstrahan ];
    platforms   = with platforms; linux ++ darwin;
    license     = licenses.asl20;
  };
}
