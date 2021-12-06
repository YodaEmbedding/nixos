{
  config,
  pkgs,
  pythonPackages,
  ...
}:

let
  pythonPackages_custom = (import ./python) {
    inherit config pkgs pythonPackages;
  };
in
{
  pythonPackages = pythonPackages_custom;

  frece = pkgs.callPackage (import ./frece) {};

  scrobblez = pkgs.callPackage (import ./scrobblez) (
    with pythonPackages; {
      inherit lib toPythonApplication;
      inherit (pythonPackages_custom) scrobblez;
    });

  zhumu = pkgs.callPackage (import ./zhumu) {};
}
