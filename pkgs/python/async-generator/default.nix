{ lib
, buildPythonPackage
, fetchPypi
}:

buildPythonPackage rec {
  pname = "async-generator";
  version = "1.10";

  src = fetchPypi {
    inherit version;
    pname = "async_generator";
    sha256 = "sha256-brs9EGwSkgqq5CzLb3h+9e79zdFm6j1ij6hHar5xIUQ=";
  };

  propagatedBuildInputs = [ ];

  doCheck = false;

  meta = with lib; {
    description = "Making it easy to write async iterators in Python 3.5";
    homepage = "https://github.com/python-trio/async_generator";
    license = licenses.mit;
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
