{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./hosts/pc_mordor
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  fonts.fonts = with pkgs; [
    font-awesome
    iosevka
    noto-fonts
    noto-fonts-cjk
    roboto
    roboto-mono
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

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;

  nixpkgs.config.packageOverrides = pkgs: rec {

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

    polybar = (pkgs.polybar.override {
      i3Support = true;
    });

    # thunar = (pkgs.xfce.thunar.override {
    #   thunarPlugins = [
    #     pkgs.xfce.thunar-archive-plugin
    #     pkgs.xfce.thunar-dropbox-plugin
    #     pkgs.xfce.thunar-volman
    #   ];
    # });

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
    (pkgs.callPackage (import ./pkgs/zhumu) {})

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
    cadence
    ddccontrol
    jack2
    libinput
    libnotify
    pasystray
    pavucontrol
    pulseaudio
    wally-cli

    # (wineWowPackages.full.override {
    #   wineRelease = "staging";
    #   mingwSupport = true;
    # })
    # (winetricks.override {
    #   wine = wineWowPackages.staging;
    # })

    # lutris
    # steam

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
      bitarray
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
    zoom-us

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
