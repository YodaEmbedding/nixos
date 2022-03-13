{ lib
, buildPythonPackage
, fetchFromGitHub
, fetchPypi
, accelerate
, hydra-slayer
, numpy
, pytest
, pytorch
, pyyaml
, tensorboardx
, tqdm
}:

buildPythonPackage rec {
  pname = "catalyst";
  version = "22.02.1";

  src = fetchFromGitHub {
    owner = "catalyst-team";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "sha256-wwNsfgn+kUkrgIMF+towPpTvYGovTDbgrk1EHpcE+AI=";
  };

  postUnpack = ''
    sed -i 's/tensorboardX<2.3.0>=2.1.0/tensorboardX<2.5.0>=2.1.0/' \
      "$sourceRoot/requirements/requirements.txt"
  '';

  propagatedBuildInputs = [
    accelerate
    hydra-slayer
    numpy
    pytorch
    pyyaml
    tensorboardx
    tqdm
  ];

  checkInputs = [
    pytest
  ];

  doCheck = false;

  meta = with lib; {
    description = "Accelerated deep learning R&D";
    homepage = "https://github.com/catalyst-team/catalyst";
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

