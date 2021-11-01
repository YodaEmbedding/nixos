{
  pkgs,
  ...
}:

with pkgs;
let
  python = python39;
  pythonPackages = python39Packages;
in
with pkgs; [

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

  cudnn
  eigen
  opencv4

  (python.withPackages (ps: with ps; [
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

  # ardour
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

]
