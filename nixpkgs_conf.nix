{
  config,
  pkgs,
  ...
}:

{
  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };

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
}
