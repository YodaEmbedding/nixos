{ lib
, buildPythonPackage
, fetchPypi
, dbus-python
}:

buildPythonPackage rec {
  pname = "mpris2";
  version = "1.0.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "11digqm1m158xj04ij5d7pmna8brd3zfca7g8rbhanbmy01vwqr6";
  };

  propagatedBuildInputs = [
    dbus-python
  ];

  doCheck = false;
  pythonImportsCheck = [ "mpris2" ];

  meta = with lib; {
    description = "Mpris2 for Python";
    homepage = "https://github.com/hugosenari/mpris2";
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
