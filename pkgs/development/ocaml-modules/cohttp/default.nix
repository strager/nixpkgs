{ lib, fetchFromGitHub, buildDunePackage
, ppx_fields_conv, ppx_sexp_conv
, base64, fieldslib, jsonm, re, stringext, uri-sexp
, stdlib-shims
}:

buildDunePackage rec {
  pname = "cohttp";
	version = "2.4.0";

	src = fetchFromGitHub {
		owner = "mirage";
		repo = "ocaml-cohttp";
		rev = "v${version}";
		sha256 = "11lz9h7nbm204zxdyvdz0qbvnlycvyxnxg4yfy84hw4w1j0zg0qp";
	};

	buildInputs = [ jsonm ppx_fields_conv ppx_sexp_conv ];

	propagatedBuildInputs = [ base64 fieldslib re stdlib-shims stringext uri-sexp ];

	meta = {
		description = "HTTP(S) library for Lwt, Async and Mirage";
		license = lib.licenses.isc;
		maintainers = [ lib.maintainers.vbgl ];
		inherit (src.meta) homepage;
	};
}
