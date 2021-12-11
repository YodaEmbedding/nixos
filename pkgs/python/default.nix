{
  config,
  pkgs,
  pythonPackages,
  ...
}:

with pkgs;
rec {
  metadata-filter = with pythonPackages;
    pkgs.callPackage ./metadata-filter {
      inherit lib buildPythonPackage fetchPypi;
    };

  mpris2 = with pythonPackages;
    pkgs.callPackage ./mpris2 {
      inherit lib buildPythonPackage fetchPypi dbus-python;
    };

  pytorch-msssim = with pythonPackages;
    pkgs.callPackage ./pytorch-msssim {
      inherit
        lib
        buildPythonPackage
        fetchPypi
        pytorch
        ;
    };

  scrobblez = with pythonPackages;
    pkgs.callPackage ./scrobblez {
      inherit
        lib
        buildPythonPackage
        fetchPypi
        metadata-filter
        mpris2
        pylast
        pyxdg
        setuptools
        ;
      };
}
