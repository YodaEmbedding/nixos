{ lib
, buildPythonPackage
, fetchFromGitHub
, fetchPypi
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
  version = "21.11";

  src = fetchFromGitHub {
    owner = "catalyst-team";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "sha256-d9lZngMGo8NfjcGwAiN9z2lN1xP6+2mcbM6NwJlVzLU=";
  };

  postUnpack = ''
    sed -i 's/tensorboardX<2.3.0>=2.1.0/tensorboardX<2.5.0>=2.1.0/' \
      "$sourceRoot/requirements/requirements.txt"
  '';

  propagatedBuildInputs = [
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

