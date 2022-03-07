{ lib
, buildPythonPackage
, fetchPypi
}:

buildPythonPackage rec {
  pname = "async-exit-stack";
  version = "1.0.1";

  src = fetchPypi {
    inherit version;
    pname = "async_exit_stack";
    sha256 = "sha256-JN4a1tD/J76XyJ1nCfpJvyDbF56vH00ubptECbgOdH0=";
  };

  propagatedBuildInputs = [ ];

  doCheck = false;

  meta = with lib; {
    description = "AsyncExitStack backport for Python 3.5+";
    homepage = "https://github.com/sorcio/async_exit_stack";
    license = licenses.psfl;
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
