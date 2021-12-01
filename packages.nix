{
  config,
  pkgs,
  ...
}:

with pkgs;
let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };

  python = python3;
  python3 = unstable.python39;
  pythonPackages = python3Packages;
  python3Packages = unstable.python39Packages;

  opencv4_override = opencv4.override {
    enableUnfree    = true;
    enableGtk3      = true;
    enableFfmpeg    = true;
    enablePython    = true;
    pythonPackages  = pythonPackages;
  };

  opencv4_python_override = pythonPackages.opencv4.override {
    enableUnfree    = true;
    enableGtk3      = true;
    enableFfmpeg    = true;
  };

  polybar_override = unstable.polybar.override {
    i3Support = true;
  };

  qimgv_override = (qimgv.overrideAttrs (old: {
    buildInputs = old.buildInputs ++ [ cudatoolkit ];
  }));

  metadata-filter = with pythonPackages;
    pkgs.callPackage ./pkgs/python/metadata-filter {
      inherit lib buildPythonPackage fetchPypi;
    };

  mpris2 = with pythonPackages;
    pkgs.callPackage ./pkgs/python/mpris2 {
      inherit lib buildPythonPackage fetchPypi dbus-python;
    };

  scrobblez = with pythonPackages;
    pkgs.callPackage ./pkgs/python/scrobblez {
      inherit
        lib
        buildPythonPackage
        fetchPypi
        metadata-filter
        mpris2
        pylast
        pyxdg
        setuptools
        ;
      };

in
with pkgs; [

  # custom packages
  (pkgs.callPackage (import ./pkgs/frece) {})
  (pkgs.callPackage (import ./pkgs/scrobblez) (with pythonPackages; {
    inherit lib toPythonApplication scrobblez;
  }))
  (pkgs.callPackage (import ./pkgs/zhumu) {})

  # shells
  bash
  zinit
  zsh

  # tools/archivers + tools/compression
  dtrx
  p7zip
  unzip
  zip

  # tools/filesystems
  ntfs3g

  # tools/graphics
  vulkan-tools

  # tools/networking
  fping
  openfortivpn
  ssh-copy-id
  sshpass
  wget

  # tools/nix
  nix-query-tree-viewer
  nix-tree

  # tools/security
  gnupg
  pinentry

  (pass.withExtensions (ext: with ext; [
    pass-otp
  ]))

  # tools/system
  at
  cron
  efibootmgr
  htop

  # tools/misc + tools/*
  bat
  fasd
  fd
  file
  fselect
  fzf
  gparted
  lf
  man
  moreutils
  neofetch
  parted
  perl532Packages.vidir
  ripgrep
  sd
  stow
  tmux
  todo-txt-cli
  trash-cli
  xclip
  xdotool
  youtube-dl
  zoxide

  # development/compilers + development/interpreters
  cargo
  clang
  cudatoolkit
  gcc
  ghc
  go
  jdk
  jre8
  llvm
  lua
  lua5_1
  luajit
  nim
  rustc
  texlive.combined.scheme-full

  (python.withPackages (ps: with ps; [
    beautifulsoup4
    bitarray
    black
    dbus-python
    isort
    matplotlib
    numba
    numpy
    omegaconf
    opencv4_python_override
    pandas
    pillow
    pip
    # poetry
    ptpython
    pygobject3
    pynvim
    pytest
    pytorch
    pytorch-lightning
    requests
    scipy
    seaborn
    scikit-learn
    snakeviz
    tensorflow-tensorboard
    tensorflowWithCuda
    torchvision
    virtualenv

    # custom
    # arxiv
    metadata-filter
    mpris2
    pylast
    # torchinfo
  ]))

  # development/libraries
  boost
  cudnn
  eigen
  ffmpeg
  glib
  glibc
  gtk2
  gtk3
  gvfs
  jasper
  libGL
  libGLU
  libcxx
  libcxxabi
  libgphoto2
  libinput
  libjpeg
  libllvm
  libnotify
  libpng
  libtiff
  libwebp
  musl
  nvidia-optical-flow-sdk
  openblas
  opencv4_override
  tbb
  vulkan-headers

  # development/tools
  autoconf
  binutils
  ccache
  clang-tools
  cmake
  gnumake
  jq
  lua51Packages.luarocks
  ninja
  rustup
  tree-sitter
  yarn

  # language servers
  haskell-language-server
  nodePackages.bash-language-server
  nodePackages.diagnostic-languageserver
  nodePackages.pyright
  nodePackages.typescript-language-server
  nodePackages.vim-language-server
  nodePackages.vscode-html-languageserver-bin
  nodePackages.vscode-json-languageserver
  nodePackages.yaml-language-server
  rnix-lsp
  rust-analyzer
  sumneko-lua-language-server

  # development/*
  nodejs
  sqlite
  stack

  # hardware
  ddccontrol
  wally-cli

  # audio
  alsaUtils
  cadence
  gst_all_1.gst-plugins-bad
  gst_all_1.gst-plugins-base
  gst_all_1.gst-plugins-good
  gst_all_1.gst-plugins-ugly
  jack2
  pamixer
  pasystray
  pavucontrol
  playerctl
  pulseaudio

  # applications/audio (user)
  ardour
  # guitarix
  spotify

  # applications/editors
  unstable.neovim
  vim
  vscode

  # applications/graphics
  darktable
  feh
  geeqie
  gimp
  gimpPlugins.resynthesizer
  gthumb
  imagemagick
  krita
  photoqt
  qimgv_override

  # tools/graphics
  exiftool
  maim
  scrot

  # applications/networking
  dropbox
  firefox
  google-chrome
  qbittorrent

  # applications/networking/instant-messengers
  discord
  skypeforlinux
  zoom-us

  # applications/terminal-emulators
  alacritty
  termite

  # applications/version-management
  delta
  git

  # applications/video
  mpv
  obs-studio
  vlc

  # applications/misc
  copyq
  dunst
  font-manager
  okular
  ranger
  redshift
  rofi
  zathura

  # applications/window-managers
  i3
  picom

  # themes
  adapta-gtk-theme
  breeze-gtk
  breeze-icons
  xorg.xcursorthemes

  # desktop utilities
  dolphin
  i3lock-color
  lxappearance
  polybar_override
  qt5ct
  xfce.tumbler
  xfce.xfconf
  xorg.xdpyinfo

  (xfce.thunar.override {
    thunarPlugins = [
      xfce.thunar-archive-plugin
      xfce.thunar-dropbox-plugin
      xfce.thunar-volman
    ];
  })

  # wine

  # (wineWowPackages.full.override {
  #   wineRelease = "staging";
  #   mingwSupport = true;
  # })

  # (winetricks.override {
  #   wine = wineWowPackages.staging;
  # })

  # games
  anki
  lutris
  steam

]
