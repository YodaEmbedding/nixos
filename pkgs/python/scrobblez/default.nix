{ lib
, buildPythonPackage
, fetchPypi
, metadata-filter
, mpris2
, pylast
, pyxdg
, setuptools
}:

buildPythonPackage rec {
  pname = "scrobblez";
  version = "0.1.0";
  # format = "other";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0lnbyipimdqh81d6l2xdz92m5jplx2prb4gd3xhzj3dh7nq44w49";
  };

  propagatedBuildInputs = [
    metadata-filter
    mpris2
    pylast
    pyxdg
    setuptools
  ];

  doCheck = false;
  pythonImportsCheck = [ "scrobblez" ];

  meta = with lib; {
    homepage = "https://github.com/YodaEmbedding/scrobblez";
    description = "Customizable last.fm scrobbler via MPRIS 2";
    license = licenses.mit;
    platforms = platforms.linux;
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
