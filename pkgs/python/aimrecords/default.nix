{ lib
, buildPythonPackage
, fetchPypi
, base58
}:

buildPythonPackage rec {
  pname = "aimrecords";
  version = "0.0.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-m1YvpbUQm0s91Pg74AYcrbrGP6gDHygbi1yK4plnBy8=";
  };

  propagatedBuildInputs = [
    base58
  ];

  doCheck = false;

  postUnpack = ''
    sed -i "s:'base58==.*':'base58':" "$sourceRoot/setup.py"
  '';

  meta = with lib; {
    description = "Record-oriented data storage";
    homepage = "https://github.com/aimhubio/aimrecords";
    maintainers = [
      {
        email = "mulhaq2005@gmail.com";
        github = "YodaEmbedding";
        githubId = 721196;
        name = "Mateen Ulhaq";
      }
    ];
  };
}
