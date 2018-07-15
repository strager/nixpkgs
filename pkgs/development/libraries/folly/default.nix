{ stdenv, fetchFromGitHub, fetchpatch, cmake, boost, libevent, double-conversion, glog
, google-gflags, gtest, libiberty, openssl }:

stdenv.mkDerivation rec {
  name = "folly-${version}";
  version = "2019.03.18.00";

  src = fetchFromGitHub {
    owner = "facebook";
    repo = "folly";
    rev = "v${version}";
    sha256 = "0g7c2lq4prcw9dd5r4q62l8kqm8frczrfq8m4mgs22np60yvmb6d";
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

  patches = [
    # Fix incorrect forward_tuple test
    (fetchpatch {
      sha256 = "0kz8v965h6xfb0f7jrnvks2x6i5q0kfj4p5hzp41jyhhxhb6hhxc";
      url = https://github.com/facebook/folly/commit/c60619007b356bb03784539dc1a347c9d4713b7e.patch;
    })
    # Fix Conv.stdChronoToTimespec test on macOS
    (fetchpatch {
      sha256 = "19bb2la0cbwvzrwsnzxqkknnzy1gym9kinx0aqyjdwfx9aialddh";
      url = https://github.com/facebook/folly/commit/acd6334f8e82d0aa754523a87f29b675082a7935.patch;
    })
  ] ++ stdenv.lib.optionals stdenv.isDarwin [
    ./disable-tests-x86_64-darwin.patch
    ./macos-10.11.patch
  ] ++ stdenv.lib.optionals stdenv.isLinux [
    ./disable-tests-x86_64-linux.patch
  ];

  cmakeFlags = [
    "-DBUILD_TESTS:BOOL=ON"
    "-DUSE_CMAKE_GOOGLE_TEST_INTEGRATION:BOOL=ON"
  ];
  CXXFLAGS = stdenv.lib.optionals stdenv.cc.isGNU [
    "-Wno-error=maybe-uninitialized"
    "-Wno-error=stringop-overflow"
  ];

  enableParallelBuilding = true;

  checkInputs = [ gtest ];
  checkTarget = "test";
  doCheck = true;

  meta = with stdenv.lib; {
    description = "An open-source C++ library developed and used at Facebook";
    homepage = https://github.com/facebook/folly;
    license = licenses.asl20;
    # 32bit is not supported: https://github.com/facebook/folly/issues/103
    platforms = [ "x86_64-darwin" "x86_64-linux" ];
    maintainers = with maintainers; [ abbradar ];
  };
}
