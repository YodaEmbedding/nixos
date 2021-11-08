{ lib
, buildPythonPackage
, fetchPypi
}:

buildPythonPackage rec {
  pname = "metadata-filter";
  version = "0.1.0";

  src = fetchPypi {
    inherit version;
    pname = "metadata_filter";
    sha256 = "1a5d75sffviy32p52hdbi34jmcshwdfbgy9i13fnj23hgfd4p670";
  };

  doCheck = false;
  pythonImportsCheck = [ "metadata_filter" ];

  meta = with lib; {
    description = "Cleaner metadata for scrobbling";
    homepage = "https://github.com/YodaEmbedding/metadata-filter";
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
