{
  ...
}:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  services.xserver.config = ''
    Section "InputClass"
      Identifier "My Mouse"
      Driver "libinput"
      MatchIsPointer "on"
      MatchProduct "Logitech MX Vertical"
      MatchVendor "Logitech"
      Option "AccelProfile" "flat"
      Option "AccelSpeed" "-0.75"
      # Option "AccelerationNumerator" "1"
      # Option "AccelerationDenominator" "1"
      # Option "AccelerationThreshold" "0"
    EndSection

    Section "Device"
      Identifier "Device0"
      Driver     "nvidia"
      VendorName "NVIDIA Corporation"
      BoardName  "GeForce GTX 1060 6GB"
      # FIX I2C ERRORS
      # http://www.ddcutil.com/nvidia/
      # https://devtalk.nvidia.com/default/topic/572292/-solved-does-gddccontrol-work-for-anyone-here-nvidia-i2c-monitor-display-ddc/#4309293
      Option "RegistryDwords" "RMUseSwI2c=0x01; RMI2cSpeed=100"
      # SCREEN TEARING
      # https://bbs.archlinux.org/viewtopic.php?pid=1716977#p1716977
      # Option "TripleBuffer" "True"
      # Option "AllowIndirectGLXProtocol" "off"
      # "ForceFullComposition" can make gaming low fps? Though this doesn't have "Full" in it...
      # TODO shouldn't that be DVI-D-0 not I-1? Try it out.
      # Option "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On}"
      # Option "metamodes" "DVI-D-0: nvidia-auto-select {ForceCompositionPipeline=On}"
      # Option "metamodes" "DVI-I-1: nvidia-auto-select {ForceCompositionPipeline=On}"
      # Option "metamodes" "nvidia-auto-select @1920x1080 +0+0 {ViewPortIn=1920x1080, ViewPortOut=1920x1080+0+0, ForceFullCompositionPipeline=On}"
    EndSection
  '';

  hardware.keyboard.zsa.enable = true;
}
