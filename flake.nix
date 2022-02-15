{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nur.url = "github:nix-community/NUR";
    # home-manager.url = "github:nix-community/home-manager/release-21.11";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-fhs-compat.url = "github:balsoft/nixos-fhs-compat";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nur, nixos-fhs-compat } @inputs:
  {
    nixosConfigurations.PC-Mordor-NixOS = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
