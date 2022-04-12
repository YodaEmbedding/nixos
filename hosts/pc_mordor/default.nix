{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./file_systems.nix
    ./hardware.nix
    ./hardware-configuration.nix
    inputs.nixos-fhs-compat.nixosModules.combined
  ];

  networking.hostName = "PC-Mordor-NixOS";
  time.timeZone = "America/Vancouver";

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      version = 2;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
    systemd-boot = {
      enable = true;
    };
  };

  environment.fhs.enable = true;
  # environment.fhs.linkLibs = true;
  # environment.lsb.enable = true;
  # environment.lsb.support32Bit = true;
}
