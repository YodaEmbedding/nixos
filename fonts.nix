{
  config,
  pkgs,
  ...
}:

{
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
