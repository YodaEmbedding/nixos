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

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
