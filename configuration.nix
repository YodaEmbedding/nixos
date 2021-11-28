{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./hosts/pc_mordor
    ./fonts.nix
    ./nixpkgs_conf.nix
    ./xdg
  ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;

  services.xserver = {
    enable = true;
    layout = "us";

    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    windowManager.i3.enable = true;

    libinput.enable = true;
  };

  services.localtime.enable = true;

  services.earlyoom.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # sound.enable = true;

  # hardware.pulseaudio = {
  #   enable = true;
  #   support32Bit = true;
  # };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    socketActivation = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    # extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    # setLdLibraryPath = true;
  };

  # users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mulhaq = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "plugdev" ];
    createHome = true;
    shell = pkgs.zsh;
  };

  security.sudo.configFile = ''
    Defaults pwfeedback
    Defaults timestamp_timeout=120
  '';

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;
  # ssh.startAgent = true;

  services.gvfs.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };

  users.extraGroups.vboxusers.members = [
    "mulhaq"
  ];

  # TODO does this do anything
  # systemd.services.dunst.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.zsh.enable = true;

  environment.variables = rec {
    BROWSER = "firefox";
    EDITOR = "nvim";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    TERMINAL = "alacritty";
    VISUAL = "nvim";
  };

  environment.systemPackages = (import ./packages.nix {
    config = config;
    pkgs = pkgs;
  });

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
