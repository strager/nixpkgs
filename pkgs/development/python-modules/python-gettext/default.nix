{ buildPythonPackage
, fetchPypi
, lib
}:

buildPythonPackage rec {
  pname = "python-gettext";
  version = "4.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "00pcqwpnir0cr5lynima9ra1y4na1pk51x8c8v1jz2dca4d50sv2";
  };

  #checkInputs = [ nose ];

#  checkPhase = ''
#    # https://github.com/pytoolz/toolz/issues/357
#    rm toolz/tests/test_serialization.py
#    nosetests toolz/tests
#  '';

  meta = with lib; {
    homepage = http://pypi.python.org/pypi/python-gettext;
    description = "Python Gettext po to mo file compiler";
    license = licenses.bsd2;
    maintainers = [ ];
  };
}
