{ lib
, buildPythonPackage
, fetchPypi
, pytest
}:

buildPythonPackage rec {
  pname = "hydra-slayer";
  version = "0.4.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-Ln7wuZ5eEVBNgJlvaJ7V7Xrodm7bjna2kzswaWYVlgQ=";
  };

  checkInputs = [
    pytest
  ];

  meta = with lib; {
    description = "PyTorch library for configuring complex applications";
    homepage = "https://github.com/catalyst-team/hydra-slayer";
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
