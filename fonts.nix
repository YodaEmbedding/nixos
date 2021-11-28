{
  config,
  pkgs,
  ...
}:

{
  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    font-awesome
    iosevka
    noto-fonts
    noto-fonts-cjk
    roboto
    roboto-mono
  ];
}
