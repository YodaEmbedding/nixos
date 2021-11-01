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
