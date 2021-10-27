let pkgs = import <nixpkgs> {}; in

{
  frece = pkgs.callPackage ./frece {};
  zhumu = pkgs.callPackage ./zhumu {};
}
