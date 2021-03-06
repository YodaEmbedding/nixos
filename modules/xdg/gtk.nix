{
  config,
  pkgs,
  ...
}:

{
  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-font-name=Noto Sans Regular 10
    gtk-theme-name=palenight
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
}
