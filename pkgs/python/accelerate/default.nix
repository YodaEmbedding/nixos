{ lib
, buildPythonPackage
, fetchPypi
, numpy
, pytorch
, pyyaml
, pytest
}:

buildPythonPackage rec {
  pname = "accelerate";
  version = "0.5.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-Z7nKIqpW2Fl9S6LgSjqeM0AJHGYNLehaZR0PVEO2gtU=";
  };

  propagatedBuildInputs = [
    numpy
    pytorch
    pyyaml
  ];

  checkInputs = [
    pytest
  ];

  meta = with lib; {
    description = "A simple way to train and use PyTorch models with multi-GPU, TPU, mixed-precision";
    homepage = "https://github.com/huggingface/accelerate";
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
