{ lib
, buildPythonPackage
, fetchFromGitHub
, fetchPypi
, cython
, aimrecords
, aimrocks
, cachetools
, click
, cryptography
, filelock
, GitPython
, numpy
, packaging
, protobuf
, psutil
, py3nvml
, RestrictedPython
, tqdm
, aiofiles
, alembic
, async-exit-stack
, async_generator
, fastapi
, jinja2
, pytz
, sqlalchemy
, uvicorn
, pillow
, grpcio
, pytest
}:

buildPythonPackage rec {
  pname = "aim";
  version = "3.6.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-d60W6c8VBhmcWuw3I09WB5SOtWFQrOfImA3a7GGM6XY=";
  };

  nativeBuildInputs = [
    cython
  ];

  propagatedBuildInputs = [
    cython
    aimrecords
    aimrocks
    cachetools
    click
    cryptography
    filelock
    GitPython
    numpy
    packaging
    protobuf
    psutil
    py3nvml
    RestrictedPython
    tqdm
    aiofiles
    alembic
    async-exit-stack
    async_generator
    fastapi
    jinja2
    pytz
    sqlalchemy
    uvicorn
    pillow
    grpcio
  ];

  checkInputs = [
    pytest
  ];

  doCheck = false;

  postUnpack = ''
    sed -i \
      -e "s:'aimrocks.*':'aimrocks':" \
      -e "s:'fastapi.*':'fastapi':" \
      -e "s:'Cython==.*':'Cython>=0.29.24':" \
      "$sourceRoot/setup.py"
  '';

  meta = with lib; {
    description = "An experiment tracker for machine learning";
    homepage = "https://github.com/aimhubio/aim";
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
