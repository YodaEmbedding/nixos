{
  config,
  pkgs,
  inputs,
  ...
}:

with pkgs;
let
  unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config = config.nixpkgs.config;
  };

  python = python39;
  pythonPackages = python39Packages;
  pythonPackages_unstable = unstable.python39Packages;

  # UNSTABLE:

  firefox = unstable.firefox;
  neovim = unstable.neovim;
  polybar_unstable = unstable.polybar;
  spotifyd_unstable = unstable.spotifyd;
  wandb = pythonPackages_unstable.wandb;

  # OVERRIDES:

  opencv4 = pkgs.opencv4.override {
    enableUnfree    = true;
    enableGtk3      = true;
    enableFfmpeg    = true;
    enablePython    = true;
    pythonPackages  = pythonPackages;
  };

  opencv4_python = pythonPackages.opencv4.override {
    enableUnfree    = true;
    enableGtk3      = true;
    enableFfmpeg    = true;
  };

  polybar = polybar_unstable.override {
    i3Support = true;
  };

  spotifyd = spotifyd_unstable.override {
    withPulseAudio  = true;
    withMpris       = true;
    withKeyring     = true;
  };

  # CUSTOM PACKAGES:

  pkgs_custom = (import ./pkgs) { inherit config pkgs pythonPackages; };

  inherit (pkgs_custom)
    frece
    scrobblez
    zhumu
    ;

  inherit (pkgs_custom.pythonPackages)
    arxiv
    catalyst
    compressai
    metadata-filter
    mpris2
    pytorch-msssim
    ;

  scrobblez_python = pkgs_custom.pythonPackages.scrobblez;

in
[

  # custom packages
  frece
  scrobblez
  zhumu

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
  waifu2x-converter-cpp  # depends: opencv

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
  perlPackages.vidir
  pplatex
  ripgrep
  sd
  stow
  tmux
  todo-txt-cli
  trash-cli
  wmctrl
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
  ruby
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
    opencv4_python
    pandas
    pillow
    pip
    poetry
    praw
    ptpython
    pygobject3
    pyinotify
    pylast
    pynvim
    pytest
    pytorch  # depends: cuda
    pytorch-lightning
    requests
    scikit-learn
    scipy
    seaborn
    snakeviz
    tensorflow-tensorboard
    tensorflowWithCuda  # depends: cuda
    tomlkit
    torchvision
    virtualenv
    wandb

    # custom
    arxiv
    catalyst
    compressai
    metadata-filter
    mpris2
    pytorch-msssim
    scrobblez_python
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
  opencv4
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

  # build-support
  pkg-config

  # language servers
  haskell-language-server
  nodePackages.bash-language-server
  nodePackages.diagnostic-languageserver
  nodePackages.pyright
  nodePackages.typescript-language-server
  nodePackages.vim-language-server
  nodePackages.vscode-langservers-extracted
  nodePackages.yaml-language-server
  rnix-lsp
  rust-analyzer
  sumneko-lua-language-server
  texlab

  # development/*
  nodejs
  sqlite
  stack

  # hardware
  ddccontrol
  wally-cli

  # audio
  alsa-utils
  cadence
  gst_all_1.gst-plugins-bad  # depends: opencv
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
  spotifyd
  spotify-tui

  # applications/editors
  neovim
  vim
  vscode

  # applications/graphics
  darktable
  feh
  gcolor2
  geeqie
  gimp
  gimpPlugins.resynthesizer
  gthumb
  imagemagick
  krita
  photoqt
  qimgv  # depends: opencv

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
  teams
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
  foxitreader
  masterpdfeditor
  obsidian
  okular
  ranger
  redshift
  rofi
  zathura

  # applications/*
  libreoffice-fresh

  # applications/window-managers
  i3
  picom

  # themes
  adapta-gtk-theme
  adapta-kde-theme
  amarena-theme
  arc-theme
  breeze-gtk
  dracula-theme
  equilux-theme
  juno-theme
  materia-kde-theme
  materia-theme
  oceanic-theme
  orchis-theme
  palenight-theme
  plata-theme
  pop-gtk-theme
  qogir-theme
  spacx-gtk-theme
  yaru-theme

  # icons
  arc-icon-theme
  breeze-icons
  maia-icon-theme
  paper-icon-theme
  pop-icon-theme
  tela-icon-theme

  # cursors
  xorg.xcursorthemes

  # desktop utilities
  dolphin
  i3lock-color
  lxappearance
  polybar
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

  # misc/tmux-plugins
  tmuxPlugins.better-mouse-mode
  tmuxPlugins.continuum
  tmuxPlugins.copycat
  tmuxPlugins.extrakto
  tmuxPlugins.fingers
  tmuxPlugins.resurrect
  tmuxPlugins.tmux-fzf

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

  # games/chess
  fairymax
  stockfish
  xboard

  # NUR
  # pkgs.nur.repos.bhipple.talon

]
