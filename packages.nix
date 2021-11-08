{
  pkgs,
  ...
}:

with pkgs;
let
  python = python3;
  python3 = python39;
  pythonPackages = python3Packages;
  python3Packages = python39Packages;

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

  polybar_override = pkgs.polybar.override {
    i3Support = true;
  };

  qimgv_override = (qimgv.overrideAttrs (old: {
    buildInputs = old.buildInputs ++ [ cudatoolkit ];
  }));

in
with pkgs; [

  (pkgs.callPackage (import ./pkgs/frece) {})
  (pkgs.callPackage (import ./pkgs/zhumu) {})

  ntfs3g

  man
  moreutils

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

  adapta-gtk-theme
  breeze-gtk
  breeze-icons
  dunst
  i3
  i3lock-color
  lxappearance
  picom
  polybar_override
  qt5ct
  xfce.xfconf
  xorg.xcursorthemes

  alsa-utils
  cadence
  ddccontrol
  jack2
  libinput
  libnotify
  pamixer
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

  cudnn
  eigen
  opencv4_override

  (python.withPackages (ps: with ps; [
    # arxiv
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
    # torchinfo
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
  qimgv_override

  ardour
  # guitarix

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

  xfce.tumbler

  discord
  skypeforlinux
  zoom-us

  (pass.withExtensions (ext: with ext; [
    pass-otp
  ]))

  anki
  copyq
  dropbox
  firefox
  font-manager
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

]
