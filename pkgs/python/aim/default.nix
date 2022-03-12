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
  version = "3.7.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-PsAkHQk8qfZV4NnvGFHPlL1UFvrn29vVC4Dy9EsCJSY=";
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

    sed -i \
      -e "s:b'""':():" \
      "$sourceRoot/aim/sdk/repo.py"
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
