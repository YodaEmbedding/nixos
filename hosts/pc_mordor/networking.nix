{
  config,
  pkgs,
  ...
}:

{
  services = {
    openssh = {
      enable = true;
      ports = [42666];
    };
  };

  networking = {
    # Enables wireless support via wpa_supplicant.
    # wireless.enable = true;

    networkmanager.enable = true;

    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    firewall = {
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };
  };
}
