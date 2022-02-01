{
  config,
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };

  nixpkgs.overlays = [
    (self: super: {
      picom = super.picom.overrideAttrs (oldAttrs: rec {
        inherit (super.picom-next) pname version src meta;
      });
    })
    inputs.nur.overlay
  ];
}
