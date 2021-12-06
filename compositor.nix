{
  config,
  pkgs,
  ...
}:

{
  services.picom = {
    experimentalBackends = true;

    backend = "glx";
    vSync = true;

    shadow = true;
    shadowOffsets = [(-7) (-7)];
    shadowExclude = [
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"   # Hidden i3 tabs
      "! name~=''"                                     # Unknown windows
      # "n:e:Notification"
      # "name = 'Notification'"
      # "name = 'Plank'"
      # "name = 'Docky'"
      # "name = 'Kupfer'"
      # "name = 'xfce4-notifyd'"
      # "name *= 'VLC'"
      # "name *= 'compton'"
      # "name *= 'picom'"
      # "name *= 'Chromium'"
      # "name *= 'Chrome'"
      # "name = 'cpt_frame_window'"
      # "class_g ?= 'Notify-osd'"
    ];

    opacityRules = [
      #"95:class_g = 'Termite'"
      #"95:class_g = 'Alacritty'"
      #"80:class_g = 'mpv' && !_NET_WM_STATE@:32a"
      #"80:class_g = 'tabbed' && !_NET_WM_STATE@:32a"
      #"80:class_g = 'zathura' && !_NET_WM_STATE@:32a"
      "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
      # "100:focused"
    ];

    settings = {
      # glx-no-stencil = true;
      # glx-copy-from-front = false;
      # use-damage = true;
      # detect-transient = true;

      shadow-radius = 7;

      blur-background = true;
      blur-background-frame = true;
      blur-background-fixed = true;
      blur-background-exclude = [
        "window_type = 'desktop'"
        # "class_i = 'dropdown'"
        "class_g = 'zoom'"
        "class_i = 'slop'"
      ];
      blur = {
        method = "dual_kawase";
        strength = 8;
      };
    };
  };
}
