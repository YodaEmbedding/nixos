{ lib
, buildPythonPackage
, fetchPypi
, feedparser
}:

buildPythonPackage rec {
  pname = "arxiv";
  version = "1.4.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "h9UEXDQq2OJOIAe9tNePQ7PVg1cnTiDYodtwxCnosKs=";
  };

  propagatedBuildInputs = [
    feedparser
  ];

  doCheck = false;
  pythonImportsCheck = [ "arxiv" ];

  meta = with lib; {
    description = "Python wrapper for the arXiv API";
    homepage = "https://github.com/lukasschwab/arxiv.py";
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
