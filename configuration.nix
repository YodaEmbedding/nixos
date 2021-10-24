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

    config = ''
      Section "InputClass"
        Identifier "My Mouse"
        Driver "libinput"
        MatchIsPointer "on"
        MatchProduct "Logitech MX Vertical"
        MatchVendor "Logitech"
        Option "AccelProfile" "flat"
        Option "AccelSpeed" "-0.75"
        # Option "AccelerationNumerator" "1"
        # Option "AccelerationDenominator" "1"
        # Option "AccelerationThreshold" "0"
      EndSection

      Section "Device"
          Identifier "Device0"
          Driver     "nvidia"
          VendorName "NVIDIA Corporation"
          BoardName  "GeForce GTX 1060 6GB"
	  # FIX I2C ERRORS
          # http://www.ddcutil.com/nvidia/
          # https://devtalk.nvidia.com/default/topic/572292/-solved-does-gddccontrol-work-for-anyone-here-nvidia-i2c-monitor-display-ddc/#4309293
          Option "RegistryDwords" "RMUseSwI2c=0x01; RMI2cSpeed=100"
	  # SCREEN TEARING
          # https://bbs.archlinux.org/viewtopic.php?pid=1716977#p1716977
          # Option "TripleBuffer" "True"
          # Option "AllowIndirectGLXProtocol" "off"
          # "ForceFullComposition" can make gaming low fps? Though this doesn't have "Full" in it...
          # TODO shouldn't that be DVI-D-0 not I-1? Try it out.
          # Option "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On}"
          # Option "metamodes" "DVI-D-0: nvidia-auto-select {ForceCompositionPipeline=On}"
          # Option "metamodes" "DVI-I-1: nvidia-auto-select {ForceCompositionPipeline=On}"
          # Option "metamodes" "nvidia-auto-select @1920x1080 +0+0 {ViewPortIn=1920x1080, ViewPortOut=1920x1080+0+0, ForceFullCompositionPipeline=On}"
      EndSection
    '';
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

  hardware.keyboard.zsa.enable = true;

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

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  fonts.fonts = with pkgs; [
    font-awesome
    iosevka
    noto-fonts
    roboto
    roboto-mono
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;

  nixpkgs.config = {
    packageOverrides = pkgs: rec {
      opencv = pkgs.opencv.override (old: {
        enableEigen = true;
        enableFfmpeg = true;
        enableGStreamer = true;
        enableGtk2 = true;
        enableJPEG = true;
        enablePNG = true;
        enablePython = true;
        enableTIFF = true;
        # enableJPEG2K = true;
      });
      # opencv4 = pkgs.opencv4.override (old: {
      #   enableContrib = true;
      #   enableEigen = true;
      #   enableJPEG = true;
      #   enableOpenblas = true;
      #   enablePNG = true;
      #   enableTIFF = true;
      #   enableWebP = true;

      #   enableFfmpeg = true;
      #   enableGPhoto2 = true;
      #   enableGStreamer = true;
      #   enableTbb = true;
      #   # enableTesseract = true;

      #   enableGtk2 = true;
      #   enableGtk3 = true;
      #   enableIpp = true;
      #   enablePython = true;
      #   enableUnfree = true;
      # });
    };
  };

  environment.variables = rec{
    BROWSER = "firefox";
    EDITOR = "nvim";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    # QT_QTA_PLATFORMTHEME = "qt5ct";
    TERMINAL = "alacritty";
    VISUAL = "nvim";
  };

  environment.systemPackages = with pkgs; [

    (pkgs.callPackage (import ./pkgs/frece) {})

    ntfs3g

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
    pinentry
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
    tree-sitter
    vim
    vscode

    boost
    cudatoolkit
    nvidia-optical-flow-sdk
    ffmpeg
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    libgphoto2
    libGL
    libGLU
    tbb
    libllvm
    libcxx
    libcxxabi
    vulkan-headers
    vulkan-tools

    libjpeg
    libpng
    libtiff
    glib
    glibc
    libcxx
    musl
    jasper
    libwebp
    gtk2
    gtk3
    openblas
    # tesseract
    # leptonica

    ccache
    autoconf
    clang
    clang-tools
    llvm
    gcc
    ghc
    gnumake
    ninja
    cmake
    go
    jdk
    rustc
    texlive.combined.scheme-full
    cargo
sqlite
# nodePackages.npm
nodejs
yarn

    (python39.withPackages (ps: with ps; [
      dbus-python
      pygobject3
      matplotlib
      numpy
      # opencv4
      pandas
      pip
      poetry
      ptpython
      pytest
      pytorch
      pytorch-lightning
      scipy
      seaborn
      tensorflow-tensorboard
      # tensorflowWithCuda
      torchvision
      virtualenv
      pynvim
      black
      isort
    ]))

    (lua.withPackages (ps: with ps; [
      luarocks
    ]))

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
    # opencv
    # opencv4
    eigen

    exiftool
    imagemagick
    maim
    scrot

    # darktable
    # geeqie
    # gimp
    # gimpPlugins.resynthesizer
    # gthumb
    # krita
    # photoqt
    # qimgv

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
    gvfs

    xdotool
    xclip

    ddccontrol
    wally-cli
    libinput

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
