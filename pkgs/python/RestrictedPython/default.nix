{ lib
, buildPythonPackage
, fetchPypi
}:

buildPythonPackage rec {
  pname = "RestrictedPython";
  version = "5.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-Y02h9sXBIqJi9DOwg+49F6mgOfjxs3eFl++0dGHNNhs=";
  };

  propagatedBuildInputs = [ ];

  doCheck = false;

  meta = with lib; {
    description = "Restricted execution environment to run untrusted code";
    homepage = "https://github.com/zopefoundation/RestrictedPython";
    license = "Zope Public License (ZPL) Version 2.1";
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
