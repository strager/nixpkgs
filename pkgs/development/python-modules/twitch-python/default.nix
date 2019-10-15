{ buildPythonPackage
, fetchPypi
, lib
, pipenv
, requests
, responses
, rx_3_0
}:

buildPythonPackage rec {
  pname = "twitch-python";
  version = "0.0.17";

  src = fetchPypi {
    inherit pname version;
    sha256 = "11cfvj2smq6nqyngdlwkdzq6ikcb2wadzavigbd83fma9v714x0k";
  };

  nativeBuildInputs = [ pipenv ];
  propagatedBuildInputs =  [ requests rx_3_0 ];
  checkInputs = [ responses ];

  meta = with lib; {
    description = "Object-oriented Twitch API for Python developers";
    homepage = https://github.com/PetterKraabol/Twitch-Python;
    license = licenses.mit;
    maintainers = with maintainers; [ strager ];
  };
}
