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
    ./networking.nix
    ./nixpkgs_conf.nix
    ./sound.nix
    ./users.nix
    ./xdg
  ];

  services = {
    earlyoom.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    localtime.enable = true;
    # openssh.enable = true;
    # printing.enable = true;
  };

  services.xserver = {
    enable = true;
    layout = "us";

    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    windowManager.i3.enable = true;

    libinput.enable = true;
  };

  environment.variables = rec {
    BROWSER = "firefox";
    EDITOR = "nvim";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    TERMINAL = "alacritty";
    VISUAL = "nvim";
  };

  environment.systemPackages = (import ./packages.nix {
    inherit config pkgs;
  });

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    # extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    # setLdLibraryPath = true;
  };

  nix.autoOptimiseStore = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.zsh.enable = true;

  security.sudo.configFile = ''
    Defaults pwfeedback
    Defaults timestamp_timeout=120
  '';

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;

  security.rtkit.enable = true;

  # ssh.startAgent = true;

  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
