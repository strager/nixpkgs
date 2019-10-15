{ fetchFromGitHub
, lib
, python3Packages
}:

python3Packages.buildPythonApplication rec {
  name = "Twitch-Chat-Downloader-${version}";
  version = "3.1.3";

  src = fetchFromGitHub {
    owner = "PetterKraabol";
    repo = "Twitch-Chat-Downloader";
    rev = version;
    sha256 = "1y1crwcfdy2726b7w3dhalh28plhpsc0nscppcgwxck9g7yb5gqg";
  };

  nativeBuildInputs = with python3Packages; [ pipenv ];
  propagatedBuildInputs = with python3Packages; [
    python-dateutil
    pytz
    requests
    twitch-python
  ];

  # Twitch-Chat-Download has no tests at all. Sanity check the command manually.
  checkPhase = ''
    "$out"/bin/tcd --help >/dev/null || exit 1
  '';

  meta = with lib; {
    description = "Download chat messages from past broadcasts on Twitch";
    license = licenses.mit;
    homepage = https://github.com/PetterKraabol/Twitch-Chat-Downloader;
    maintainers = with maintainers; [ strager ];
  };
}
