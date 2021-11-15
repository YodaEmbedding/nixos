{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./file_systems.nix
    ./hardware.nix
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
}
