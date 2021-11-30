{
  config,
  pkgs,
  ...
}:

{
  fonts.fontDir.enable = true;

  fonts.fonts = with pkgs; [
    corefonts
    fira-code
    fira-code-symbols
    font-awesome
    iosevka
    noto-fonts
    noto-fonts-cjk
    roboto
    roboto-mono
    vistafonts
  ];
}
