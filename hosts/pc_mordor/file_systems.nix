{
  ...
}:

{
  boot.supportedFilesystems = [ "ntfs" ];

  # fileSystems."/" = {
  #   device = "/dev/disk/by-label/nixos";
  #   fsType = "ext4";
  #   options = [ "rw" "relatime" "data=ordered" ];
  # };

  fileSystems."/".options = [ "rw" "relatime" "data=ordered" ];

  fileSystems."/mnt/archlinux" = {
    device = "/dev/disk/by-label/archlinux";
    fsType = "ext4";
    options = [ "rw" "relatime" "data=ordered" ];
  };

  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-label/windows";
    fsType = "ntfs";
    options = [
      "defaults" "windows_names" "locale=en_US.utf8"
      "uid=1000" "gid=1000"
    ];
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-label/data";
    fsType = "ext4";
    options = [ "rw" "relatime" "data=ordered" ];
  };

  fileSystems."/mnt/data2" = {
    device = "/dev/disk/by-label/data2";
    fsType = "ext4";
    options = [ "rw" "relatime" "data=ordered" ];
  };

  fileSystems."/mnt/data3" = {
    device = "/dev/disk/by-label/data3";
    fsType = "ext4";
    options = [ "rw" "relatime" "data=ordered" ];
  };

  fileSystems."/mnt/data4" = {
    device = "/dev/disk/by-label/data4";
    fsType = "ntfs";
    options = [
      "defaults" "windows_names" "locale=en_US.utf8"
      "uid=1000" "gid=1000"
    ];
  };
}
