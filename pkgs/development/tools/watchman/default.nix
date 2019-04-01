{ stdenv, lib, config, fetchFromGitHub, autoconf, automake, pcre,
  libtool, pkgconfig, openssl,
  confFile ? config.watchman.confFile or null,
  withApple ? stdenv.isDarwin, CoreServices, CoreFoundation
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
  patches = [ ./watchman-config-file.patch ];

  buildInputs = [ pcre openssl ]
               ++ lib.optionals withApple [ CoreFoundation CoreServices ];
  nativeBuildInputs = [ autoconf automake pkgconfig libtool ];

  configureFlags = [
      "--enable-lenient"
      "--enable-conffile=${if confFile == null then "no" else confFile}"
      "--with-pcre=yes"

      # For security considerations re: --disable-statedir, see:
      # https://github.com/facebook/watchman/issues/178
      "--disable-statedir"
  ];

  prePatch = ''
    patchShebangs .
  '';

  preConfigure = ''
    ./autogen.sh
  '';

  meta = with lib; {
    description = "Watches files and takes action when they change";
    homepage    = https://facebook.github.io/watchman;
    maintainers = with maintainers; [ cstrahan ];
    platforms   = with platforms; linux ++ darwin;
    license     = licenses.asl20;
  };
}
