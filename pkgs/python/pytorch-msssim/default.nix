{ lib
, buildPythonPackage
, fetchPypi
, pytorch
}:

buildPythonPackage rec {
  pname = "pytorch-msssim";
  version = "0.2.1";

  src = fetchPypi {
    inherit version;
    pname = "pytorch_msssim";
    sha256 = "sha256-04Oh4miaYOE/3e7O5OD8rOmZveVYdntOsXY97Le/47s=";
  };

  propagatedBuildInputs = [
    pytorch
  ];

  doCheck = false;

  pythonImportsCheck = [ "pytorch_msssim" ];

  meta = with lib; {
    description = "Fast and differentiable MS-SSIM and SSIM for PyTorch";
    homepage = "https://github.com/VainF/pytorch-msssim";
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
