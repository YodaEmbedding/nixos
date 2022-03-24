{
  self,
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./hosts/pc_mordor
    ./modules/compositor.nix
    ./modules/fonts.nix
    ./modules/networking.nix
    ./modules/nixpkgs_conf.nix
    ./modules/sound.nix
    ./modules/users.nix
    ./modules/xdg
    inputs.nix-ld.nixosModules.nix-ld
  ];

  services = {
    ddccontrol.enable = true;
    earlyoom.enable = true;
    fstrim.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    localtime.enable = true;
    # openssh.enable = true;
    picom.enable = true;
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
    inherit config pkgs inputs;
  });

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  nix = {
    autoOptimiseStore = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    package = pkgs.nixFlakes;
  };

  # SUID wrappers, configurations, or start in user sessions.
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    zsh.enable = true;
  };

  security = {
    pam.services.lightdm.enableGnomeKeyring = true;
    rtkit.enable = true;
    sudo.configFile = ''
      Defaults pwfeedback
      Defaults timestamp_timeout=120
    '';
  };

  systemd.enableUnifiedCgroupHierarchy = false;

  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
  };

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
