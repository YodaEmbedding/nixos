{ lib
, buildPythonPackage
, fetchPypi
, cudatoolkit
, xmltodict
}:

buildPythonPackage rec {
  pname = "py3nvml";
  version = "0.2.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-Ce4dBFmKbmZOJEZfgEzjv+EZpv21Ni3xwWj4qpKfvXM=";
  };

  propagatedBuildInputs = [
    cudatoolkit
    xmltodict
  ];

  doCheck = false;

  meta = with lib; {
    description = "Python 3 bindings for the NVIDIA Management Library";
    homepage = "https://github.com/fbcotter/py3nvml";
    license = licenses.bsd3;
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
