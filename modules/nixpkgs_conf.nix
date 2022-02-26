{
  self,
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
    inputs.nix-alien.overlay
    # inputs.nix-ld.nixosModules.nix-ld
    # self.inputs.nix-alien.overlay
    # self.inputs.nix-ld.nixosModules.nix-ld
    inputs.nur.overlay
  ];
}
