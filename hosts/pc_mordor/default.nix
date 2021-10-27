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
}
