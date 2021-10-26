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

      # neovim = pkgs.neovim.override (
      #   pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins:
      #     pkgs.tree-sitter.allGrammars)
      # );

      # opencv = pkgs.opencv.override (old: {
      #   enableEigen = true;
      #   enableFfmpeg = true;
      #   enableGStreamer = true;
      #   enableGtk2 = true;
      #   enableJPEG = true;
      #   enablePNG = true;
      #   enablePython = true;
      #   enableTIFF = true;
      #   # enableJPEG2K = true;
      # });

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

      # thunar = (pkgs.xfce.thunar.override {
      #   thunarPlugins = [
      #     pkgs.xfce.thunar-archive-plugin
      #     pkgs.xfce.thunar-dropbox-plugin
      #     pkgs.xfce.thunar-volman
      #   ];
      # });

    };
  };

  environment.variables = rec {
    BROWSER = "firefox";
    EDITOR = "nvim";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    QT_QTA_PLATFORMTHEME = "qt5ct";
    TERMINAL = "alacritty";
    VISUAL = "nvim";
  };

  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-font-name=Noto Sans Regular 10
    gtk-theme-name=Adapta-Nokto-Eta
    gtk-icon-theme-name=breeze-dark
    gtk-cursor-theme-name=Breeze_Snow
    gtk-cursor-theme-size=0
    gtk-application-prefer-dark-theme=1
    gtk-toolbar-style=GTK_TOOLBAR_ICONS
    gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
    gtk-button-images=1
    gtk-menu-images=1
    gtk-enable-event-sounds=1
    gtk-enable-input-feedback-sounds=1
    gtk-xft-antialias=1
    gtk-xft-hinting=1
    gtk-xft-hintstyle=hintfull
    gtk-xft-rgba=rgb
  '';

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
    file
    fping
    fselect
    fzf
    gnupg
    gparted
    htop
    lf
    neofetch
    parted
    perl532Packages.vidir
    pinentry
    ranger
    ripgrep
    sd
    ssh-copy-id
    sshpass
    todo-txt-cli
    wget
    zinit
    zoxide
    zsh

    # unixtools.col
    # unixtools.fdisk
    # unixtools.fsck
    # unixtools.ping
    # unixtools.route
    # unixtools.top
    # unixtools.util-linux
    # unixtools.watch

    adapta-gtk-theme
    breeze-gtk
    breeze-icons
    dunst
    i3
    i3lock-color
    lxappearance
    picom
    polybar
    qt5ct
    xfce.xfconf
    xorg.xcursorthemes

    alsa-utils
    ddccontrol
    jack2
    libinput
    pavucontrol
    pulseaudio
    wally-cli

    xclip
    xdotool

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
    ffmpeg
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    libGL
    libGLU
    libcxx
    libcxxabi
    libgphoto2
    libllvm
    nvidia-optical-flow-sdk
    tbb
    vulkan-headers
    vulkan-tools

    glib
    glibc
    gtk2
    gtk3
    jasper
    libcxx
    libjpeg
    libpng
    libtiff
    libwebp
    musl
    openblas

    # tesseract
    # leptonica

    autoconf
    cargo
    ccache
    clang
    clang-tools
    cmake
    gcc
    ghc
    gnumake
    go
    jdk
    llvm
    nim
    ninja
    nodejs
    rustc
    sqlite
    texlive.combined.scheme-full
    yarn

    lua
    lua51Packages.luarocks
    lua5_1
    luajit

    # clangd
    haskell-language-server
    nodePackages.bash-language-server
    nodePackages.diagnostic-languageserver
    nodePackages.pyright
    nodePackages.typescript-language-server
    nodePackages.vim-language-server
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    rust-analyzer
    sumneko-lua-language-server

    # TODO compile OpenCV with more flags
    # https://discourse.nixos.org/t/how-to-set-up-opencv4-with-python-bindings-and-a-gui/11998/9
    cudnn
    eigen
    opencv
    opencv4

    # (pkgs.opencv.override (old: {
    #   enableEigen = true;
    #   enableFfmpeg = true;
    #   enableGStreamer = true;
    #   enableGtk2 = true;
    #   enableJPEG = true;
    #   enablePNG = true;
    #   enablePython = true;
    #   enableTIFF = true;
    #   # enableJPEG2K = true;
    # }))

    # (pkgs.opencv4.override (old: {
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
    # }))

    (python39.withPackages (ps: with ps; [
      beautifulsoup4
      black
      dbus-python
      isort
      matplotlib
      numpy
      opencv4
      pandas
      pillow
      pip
      poetry
      ptpython
      pygobject3
      pynvim
      pytest
      pytorch
      pytorch-lightning
      requests
      scipy
      seaborn
      tensorflow-tensorboard
      tensorflowWithCuda
      torchvision
      virtualenv
    ]))

    exiftool
    imagemagick
    maim
    scrot

    darktable
    feh
    geeqie
    gimp
    gimpPlugins.resynthesizer
    gthumb
    krita
    photoqt
    # qimgv

    mpv
    okular
    spotify
    vlc
    youtube-dl
    zathura

    (xfce.thunar.override {
      thunarPlugins = [
        xfce.thunar-archive-plugin
        xfce.thunar-dropbox-plugin
        xfce.thunar-volman
      ];
    })

    # shared-mime-info
    xfce.tumbler

    discord
    skypeforlinux
    zoom

    (pass.withExtensions (ext: with ext; [
      # pass-import
      pass-otp
    ]))

    anki
    copyq
    dropbox
    firefox
    google-chrome
    gvfs
    obs-studio
    openfortivpn
    playerctl
    qbittorrent
    redshift
    rofi
    steam
    trash-cli
    zbar

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
