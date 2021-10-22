{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "ntfs" ];

  # fileSystems."/" = {
  #   device = "/dev/disk/by-label/nixos";
  #   fsType = "ext4";
  #   options = [ "rw" "relatime" "data=ordered" ];
  # };

  fileSystems."/".options = [ "rw" "relatime" "data=ordered" ];

  fileSystems."/mnt/archlinux" = {
    device = "/dev/disk/by-label/archlinux";
    fsType = "ext4";
    options = [ "rw" "relatime" "data=ordered" ];
  };

  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-label/windows";
    fsType = "ntfs";
    options = [
      "defaults" "windows_names" "locale=en_US.utf8"
      "uid=1000" "gid=1000"
    ];
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-label/data";
    fsType = "ext4";
    options = [ "rw" "relatime" "data=ordered" ];
  };

  fileSystems."/mnt/data2" = {
    device = "/dev/disk/by-label/data2";
    fsType = "ext4";
    options = [ "rw" "relatime" "data=ordered" ];
  };

  fileSystems."/mnt/data3" = {
    device = "/dev/disk/by-label/data3";
    fsType = "ext4";
    options = [ "rw" "relatime" "data=ordered" ];
  };

  fileSystems."/mnt/data4" = {
    device = "/dev/disk/by-label/HDDP2";
    # device = "/dev/disk/by-label/data4";
    fsType = "ntfs";
    options = [
      "defaults" "windows_names" "locale=en_US.utf8"
      "uid=1000" "gid=1000"
    ];
  };

  time.timeZone = "America/Vancouver";

  networking.hostName = "PC-Mordor-NixOS";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # fonts = {
  #   fontDir.enable = true;
  #   fonts = with pkgs; [
  #     ubuntu_font_family
  #   ];
  #   fontconfig.defaultFonts = {
  #     sansSerif = [ "Ubuntu" ];
  #     monospace = [ "Ubuntu Mono" ];
  #   };
  # };

  services.xserver = {
    enable = true;
    layout = "us";

    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    windowManager.i3.enable = true;

    libinput.enable = true;
    videoDrivers = [ "nvidia" ];
  };

  services.localtime.enable = true;

  services.earlyoom.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  # TODO pipewire

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    # extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    # setLdLibraryPath = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mulhaq = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" ];
    createHome = true;
    shell = pkgs.zsh;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = with pkgs; [

    ntfs3g

    font-awesome
    iosevka
    noto-fonts

    man

    # tools/archivers tools/compression
    dtrx
    p7zip
    unzip
    zip

    at
    bash
    bat
    cron
    delta
    fasd
    fd
    fselect
    fzf
    gnupg
    gparted
    htop
    lf
    neofetch
    parted
    perl532Packages.vidir
    ranger
    ripgrep
    ssh-copy-id
    sshpass
    todo-txt-cli
    unixtools.col
    unixtools.fdisk
    unixtools.fsck
    unixtools.ping
    unixtools.route
    unixtools.top
    unixtools.watch
    wget
    zinit
    zoxide
    zsh

    # unixtools.util-linux
    # ...

    dunst
    i3
    i3lock-color
    pavucontrol
    picom
    polybar

    alacritty
    binutils
    git
    jq
    jre8
    neovim
    rustup
    stack
    stow
    termite
    tmux
    vim
    vscode

    boost
    cudatoolkit
    libGL
    libGLU
    vulkan-headers
    vulkan-tools
    ffmpeg

# libjpeg
# libpng
# libtiff
# libwebp
# gtk2
# gtk3
# openblas

    autoconf
    cargo
    clang
    gcc
    ghc
    gnumake
    go
    jdk
    lua
    rustc

    python39
    python39Packages.matplotlib
    python39Packages.numpy
    python39Packages.pandas
    python39Packages.pip
    python39Packages.poetry
    python39Packages.ptpython
    python39Packages.pytest
    python39Packages.pytorch
    python39Packages.pytorch-lightning
    python39Packages.scipy
    python39Packages.seaborn
    python39Packages.tensorflow-tensorboard
    python39Packages.tensorflowWithCuda
    python39Packages.torchvision
    python39Packages.virtualenv

    # clangd
    haskell-language-server
    nodePackages.bash-language-server
    nodePackages.diagnostic-languageserver
    nodePackages.pyright
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    nodePackages.typescript-language-server
    nodePackages.vim-language-server
    rust-analyzer
    sumneko-lua-language-server

    # TODO compile OpenCV with more flags
    # https://discourse.nixos.org/t/how-to-set-up-opencv4-with-python-bindings-and-a-gui/11998/9
    cudnn
    opencv
    eigen

    exiftool
    imagemagick
    maim
    scrot

    darktable
    geeqie
    gimp
    gimpPlugins.resynthesizer
    gthumb
    krita
    photoqt
    qimgv

    libsForQt5.okular
    mpv
    spotify
    vlc
    youtube-dl
    zathura

    # https://nixos.org/manual/nixos/stable/index.html#sec-xfce
    # TODO Should not be here...?
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-dropbox-plugin
    xfce.thunar-volman

    discord
    skypeforlinux
    zoom

    anki
    copyq
    dropbox
    firefox
    google-chrome
    obs-studio
    pass
    qbittorrent
    redshift
    rofi
    steam
    trash-cli

    ddccontrol
    wally-cli

  ];

    # ardour
    # cadence
    # guitarix

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
