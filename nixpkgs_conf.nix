{
  config,
  pkgs,
  ...
}:

{
  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };

  nixpkgs.config.packageOverrides = pkgs: rec {

    polybar = (pkgs.polybar.override {
      i3Support = true;
    });

  };
}
