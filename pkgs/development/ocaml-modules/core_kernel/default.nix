{stdenv, buildOcaml, fetchFromGitHub, type_conv,
 bin_prot_p4, comparelib, custom_printf, enumerate,
 fieldslib_p4, herelib, pa_bench, pa_test, pa_ounit,
 pipebang, sexplib_p4, typerep_p4, variantslib_p4}:

buildOcaml rec {
  name = "core_kernel";
  version = "v0.13.0";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchFromGitHub {
    owner = "janestreet";
    repo = "core_kernel";
    rev = "v${version}";
    sha256 = "0yqvxdmkgcwgx3npgncpdqwkpdxiqr1q41wci7589s8z7xi5nwyz";
  };

  hasSharedObjects = true;

  buildInputs = [ ];
  propagatedBuildInputs = [ type_conv bin_prot_p4 comparelib custom_printf
                            enumerate fieldslib_p4 herelib pipebang sexplib_p4
                            typerep_p4 variantslib_p4 ];

  meta = with stdenv.lib; {
    homepage = https://github.com/janestreet/core_kernel;
    description = "Jane Street Capital's standard library overlay (kernel)";
    license = licenses.asl20;
    maintainers = [ maintainers.ericbmerritt ];
  };
}
