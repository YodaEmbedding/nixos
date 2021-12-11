{ lib
, buildPythonPackage
, fetchPypi
, matplotlib
, numpy
, pillow
, pybind11
, pytest
, pytorch
, pytorch-msssim
, scipy
, torchvision
}:

buildPythonPackage rec {
  pname = "compressai";
  version = "1.1.9";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-8wHFKUNjjx1dxbiiXawfm/M90JwBNrCUwhUmvyKqRoc=";
  };

  buildInputs = [
    pybind11
  ];

  propagatedBuildInputs = [
    matplotlib
    numpy
    pillow
    pybind11
    pytorch
    pytorch-msssim
    scipy
    torchvision
  ];

  checkInputs = [
    pytest
  ];

  meta = with lib; {
    description = "PyTorch library for end-to-end deep image compression research";
    homepage = "https://github.com/InterDigitalInc/CompressAI";
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
