let pkgs = import <nixpkgs> {}; in

{
  frece = pkgs.callPackage ./frece {};
  scrobblez = pkgs.callPackage ./scrobblez {};
  zhumu = pkgs.callPackage ./zhumu {};
}
