{ stdenv, lib, config, fetchFromGitHub, pcre,
  openssl,
  confFile ? config.watchman.confFile or null,
  withApple ? stdenv.isDarwin, CoreServices, CoreFoundation,
  cmake,
  libevent,
  glog,
  gflags,
  folly,
}:

stdenv.mkDerivation rec {
  name = "watchman-${version}";

  version = "4.9.4";

  src = fetchFromGitHub {
    owner = "facebook";
    repo = "watchman";
    rev = "6af1de6af496aeeb66fe864cc760d99344531271";
    sha256 = "0fkv5iba97ai29ix262p8gw7ych6mqrcknn1pl95zj1gavr8ydrg";
  };
  patches = [
    ./conflicts.patch
    ./cxxflags.patch
    ./no-python.patch
    ./pcre.patch
    ./watchman-config-file-1.patch
    ./watchman-config-file-2.patch
    ./watchman-config-file.patch
    ./watchman-state-dir.patch
  ];

  buildInputs = [ pcre openssl libevent glog folly gflags ]
               ++ lib.optionals withApple [ CoreFoundation CoreServices ];
  nativeBuildInputs = [ cmake ];

  cmakeFlags = [
    "-DCMAKE_CXX_STANDARD=14"
    "-DWATCHMAN_CONFIG_FILE:STRING="
    "-DWATCHMAN_STATE_DIR:STRING="
  ];
  CXXFLAGS = [ "-D__ASSERT_MACROS_DEFINE_VERSIONS_WITHOUT_UNDERSCORES=0" ];

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
