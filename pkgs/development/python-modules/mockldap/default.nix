{ buildPythonPackage
, fetchPypi
, lib
, sphinx
, flake8
, pytest
, pytestcov
, pytest-flakes
, pytestpep8
, ldap
, funcparserlib
, mock
}:

buildPythonPackage rec {
  version = "0.3.0.post1";
  pname = "mockldap";

  src = fetchPypi {
    inherit pname version;
    sha256 = "09gnr4pbp7mhj2f1scz3i72alhk5862q0fcpfndq6dpzbv4jyj2c";
  };
  patches = [ ./fix-setup-py-tests.patch ];

  propagatedBuildInputs = [ funcparserlib ldap mock ];
  checkInputs = [
#    sphinx
#    flake8
#    pytest
#    pytestcov
#    pytest-flakes
#    pytestpep8
  ];

  meta = with lib; {
    description = "A simple mock implementation of python-ldap";
    homepage = https://github.com/psagers/mockldap;
    #license = licenses.psfl; @@@
    #maintainers = with maintainers; [ jonringer ]; @@@
    #platforms = platforms.unix; @@@
  };
}

