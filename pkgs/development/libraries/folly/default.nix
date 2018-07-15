{ stdenv, fetchFromGitHub, cmake, boost, libevent, double-conversion, glog
, google-gflags, gtest, libiberty, openssl }:

stdenv.mkDerivation rec {
  name = "folly-${version}";
  version = "2019.01.28.00";

  src = fetchFromGitHub {
    owner = "facebook";
    repo = "folly";
    rev = "v${version}";
    sha256 = "0ll7ivf59s4xpc6wkyxnl1hami3s2a0kq8njr57lxiqy938clh4g";
  };

  nativeBuildInputs = [ cmake ];

  # See CMake/folly-deps.cmake in the Folly source tree.
  buildInputs = [
    boost
    double-conversion
    glog
    google-gflags
    libevent
    libiberty
    openssl
  ];

  patches = [ ./cxxflags.patch ]
    ++ stdenv.lib.optionals doCheck [ ./test-gflags.patch ./disable-tests-x86_64-linux.patch ]
    ++ stdenv.lib.optionals stdenv.isDarwin [ ./macos-10.11.patch ];

  cmakeFlags = stdenv.lib.optionals doCheck [ "-DBUILD_TESTS:BOOL=ON" "-DUSE_CMAKE_GOOGLE_TEST_INTEGRATION:BOOL=ON" ];
  CXXFLAGS = stdenv.lib.optionals stdenv.cc.isGNU [ "-Wno-error=maybe-uninitialized" "-Wno-error=stringop-overflow" ];

  enableParallelBuilding = true;

  checkInputs = [ gtest ];
  checkTarget = "test";
  doCheck = !stdenv.isDarwin;

  meta = with stdenv.lib; {
    description = "An open-source C++ library developed and used at Facebook";
    homepage = https://github.com/facebook/folly;
    license = licenses.asl20;
    # 32bit is not supported: https://github.com/facebook/folly/issues/103
    platforms = [ "x86_64-darwin" "x86_64-linux" ];
    maintainers = with maintainers; [ abbradar ];
  };
}
