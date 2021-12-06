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

  nixpkgs.overlays = [
    (self: super: {
      picom = super.picom.overrideAttrs (prev: {
        version = "git";
        src = pkgs.fetchFromGitHub {
          owner = "yshui";
          repo = "picom";
          rev = "31e58712ec11b198340ae217d33a73d8ac73b7fe";
          sha256 = "sha256-VBnIzisg/7Xetd/AWVHlnaWXlxX+wqeYTpstO6+T5cE=";
        };
      });
    })
  ];
}
