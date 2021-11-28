{
  config,
  pkgs,
  ...
}:

{
  # users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mulhaq = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "plugdev" ];
    createHome = true;
    shell = pkgs.zsh;
  };

  users.extraGroups.vboxusers.members = [
    "mulhaq"
  ];
}
