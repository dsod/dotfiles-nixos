{ home, colorscheme }:
let
  inherit (home.sessionVariables) TERMINAL BROWSER EDITOR;
in
''
  general {
    sensitivity=0.5
    gaps_in=10
    gaps_out=15
    border_size=2.7
    col.active_border=0xff${colorscheme.colors.base0C}
    col.inactive_border=0xff${colorscheme.colors.base02}
    col.group_border_active=0xff${colorscheme.colors.base0B}
    col.group_border=0xff${colorscheme.colors.base04}
  }

  decoration {
    active_opacity=0.94
    inactive_opacity=0.84
    fullscreen_opacity=1.0
    rounding=5
    blur=true
    blur_size=5
    blur_passes=3
    blur_new_optimizations=true
    blur_ignore_opacity=true
    drop_shadow=true
    shadow_range=12
    shadow_offset=3 3
    col.shadow=0x44000000
    col.shadow_inactive=0x66000000
  }

  animations {
    enabled=true

    bezier=easein,0.11, 0, 0.5, 0
    bezier=easeout,0.5, 1, 0.89, 1
    bezier=easeinout,0.45, 0, 0.55, 1

    animation=windowsIn,1,3,easeout,slide
    animation=windowsOut,1,3,easein,slide
    animation=windowsMove,1,3,easeout

    animation=fadeIn,1,3,easeout
    animation=fadeOut,1,3,easein
    animation=fadeSwitch,1,3,easeout
    animation=fadeShadow,1,3,easeout
    animation=fadeDim,1,3,easeout
    animation=border,1,3,easeout

    animation=workspaces,1,2,easeout,slide
  }

  dwindle {
    split_width_multiplier=1.35
  }

  misc {
    vfr=on
  }

  input {
    force_no_accel=true
    kb_layout=us,se
    kb_options = grp:alt_caps_toggle,caps:super
    follow_mouse=2
    accel_profile=flat
    repeat_delay = 300
    repeat_rate = 80
    touchpad {
      natural_scroll = yes
      scroll_factor = 0.6
      disable_while_typing=false
    }
  }

  # Startup
  exec-once = blueman-applet
  exec-once = nm-applet --indicator
  exec-once=waybar
  exec-once=mako
  exec-once=swayidle -w
  exec-once=wpaperd
  exec-once=hyprctl setcursor Catppuccin-Macchiato-Dark-Cursors 24

  windowrule=workspace 1 silent,kitty
  windowrule=workspace 2 silent,google-chrome-stable
  windowrule=workspace 5 silent,slack
  windowrule=workspace 5 silent,spotify

  windowrule=float,blueman
  windowrule=float,nm-connection-editor|pavucontrolk
  windowrule=float,thunar

  $hyprutils = ~/scripts/hypr_util

  # Mouse binding
  bindm=SUPER,mouse:272,movewindow
  bindm=SUPER,mouse:273,resizewindow

  # Program bindings
  bind=SUPER,q,exec,${TERMINAL}
  bind=SUPER,w,killactive
  bind=SUPER,v,exec,${TERMINAL} $SHELL -ic ${EDITOR}
  bind=SUPER,b,exec,${BROWSER}

  bind=SUPER,space,exec,wofi -S drun --width 600 --height 400
  bind=SUPER,s,exec,pass-wofi

  # Reset waybar
  bind=SUPER,F1,exec, bash -c "~/.scripts/hypr_util --rwb"

  # Lock screen
  bind=SUPER,l,exec,swaylock -S

  # Screenshots
  bind=,Print,exec,grimblast --notify copy area
  bind=SHIFT,Print,exec,grimblast --notify copy active
  bind=CONTROL,Print,exec,grimblast --notify copy screen
  bind=SUPER,Print,exec,grimblast --notify copy window
  bind=ALT,Print,exec,grimblast --notify copy output

  # Keyboard controls (brightness, media, sound, etc)
  bind=,XF86MonBrightnessUp,exec,light -A 10
  bind=,XF86MonBrightnessDown,exec,light -U 10

  bind=,XF86AudioNext,exec,playerctl next
  bind=,XF86AudioPrev,exec,playerctl previous
  bind=,XF86AudioPlay,exec,playerctl play-pause
  bind=,XF86AudioStop,exec,playerctl stop
  bind=ALT,XF86AudioNext,exec,playerctld shift
  bind=ALT,XF86AudioPrev,exec,playerctld unshift
  bind=ALT,XF86AudioPlay,exec,systemctl --user restart playerctld

  bind=,XF86AudioRaiseVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ +5%
  bind=,XF86AudioLowerVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ -5%
  bind=,XF86AudioMute,exec,pactl set-sink-mute @DEFAULT_SINK@ toggle

  bind=SHIFT,XF86AudioMute,exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle
  bind=,XF86AudioMicMute,exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle


  # Window manager controls
  bind=SUPER,t,togglesplit
  bind=SUPER,f,fullscreen,1
  bind=SUPERSHIFT,f,fullscreen,0
  bind=SUPERSHIFT,space,togglefloating

  bind=SUPER,minus,splitratio,-0.25
  bind=SUPERSHIFT,minus,splitratio,-0.3333333

  bind=SUPER,equal,splitratio,0.25
  bind=SUPERSHIFT,equal,splitratio,0.3333333

  bind=SUPER,g,togglegroup
  bind=SUPER,apostrophe,changegroupactive,f
  bind=SUPERSHIFT,apostrophe,changegroupactive,b

  bind=SUPER,left,movefocus,l
  bind=SUPER,right,movefocus,r
  bind=SUPER,up,movefocus,u
  bind=SUPER,down,movefocus,d
  bind=SUPER,h,movefocus,l
  bind=SUPER,l,movefocus,r
  bind=SUPER,k,movefocus,u
  bind=SUPER,j,movefocus,d

  bind=SUPERSHIFT,left,swapwindow,l
  bind=SUPERSHIFT,right,swapwindow,r
  bind=SUPERSHIFT,up,swapwindow,u
  bind=SUPERSHIFT,down,swapwindow,d
  bind=SUPERSHIFT,h,swapwindow,l
  bind=SUPERSHIFT,l,swapwindow,r
  bind=SUPERSHIFT,k,swapwindow,u
  bind=SUPERSHIFT,j,swapwindow,d

  bind=SUPERCONTROL,left,focusmonitor,l
  bind=SUPERCONTROL,right,focusmonitor,r
  bind=SUPERCONTROL,up,focusmonitor,u
  bind=SUPERCONTROL,down,focusmonitor,d
  bind=SUPERCONTROL,h,focusmonitor,l
  bind=SUPERCONTROL,l,focusmonitor,r
  bind=SUPERCONTROL,k,focusmonitor,u
  bind=SUPERCONTROL,j,focusmonitor,d

  bind=SUPERCONTROL,1,focusmonitor,DP-1
  bind=SUPERCONTROL,2,focusmonitor,DP-2
  bind=SUPERCONTROL,3,focusmonitor,DP-3

  bind=SUPERCONTROLSHIFT,left,movewindow,mon:l
  bind=SUPERCONTROLSHIFT,right,movewindow,mon:r
  bind=SUPERCONTROLSHIFT,up,movewindow,mon:u
  bind=SUPERCONTROLSHIFT,down,movewindow,mon:d
  bind=SUPERCONTROLSHIFT,h,movewindow,mon:l
  bind=SUPERCONTROLSHIFT,l,movewindow,mon:r
  bind=SUPERCONTROLSHIFT,k,movewindow,mon:u
  bind=SUPERCONTROLSHIFT,j,movewindow,mon:d

  bind=SUPERALT,left,movecurrentworkspacetomonitor,l
  bind=SUPERALT,right,movecurrentworkspacetomonitor,r
  bind=SUPERALT,up,movecurrentworkspacetomonitor,u
  bind=SUPERALT,down,movecurrentworkspacetomonitor,d
  bind=SUPERALT,h,movecurrentworkspacetomonitor,l
  bind=SUPERALT,l,movecurrentworkspacetomonitor,r
  bind=SUPERALT,k,movecurrentworkspacetomonitor,u
  bind=SUPERALT,j,movecurrentworkspacetomonitor,d

  bind=SUPER,u,togglespecialworkspace
  bind=SUPERSHIFT,u,movetoworkspace,special

  bind=SUPER,1,workspace,01
  bind=SUPER,2,workspace,02
  bind=SUPER,3,workspace,03
  bind=SUPER,4,workspace,04
  bind=SUPER,5,workspace,05
  bind=SUPER,6,workspace,06
  bind=SUPER,7,workspace,07
  bind=SUPER,8,workspace,08
  bind=SUPER,9,workspace,09
  bind=SUPER,0,workspace,10

  bind=SUPERSHIFT,1,movetoworkspacesilent,01
  bind=SUPERSHIFT,2,movetoworkspacesilent,02
  bind=SUPERSHIFT,3,movetoworkspacesilent,03
  bind=SUPERSHIFT,4,movetoworkspacesilent,04
  bind=SUPERSHIFT,5,movetoworkspacesilent,05
  bind=SUPERSHIFT,6,movetoworkspacesilent,06
  bind=SUPERSHIFT,7,movetoworkspacesilent,07
  bind=SUPERSHIFT,8,movetoworkspacesilent,08
  bind=SUPERSHIFT,9,movetoworkspacesilent,09
  bind=SUPERSHIFT,0,movetoworkspacesilent,10

  blurls=waybar
''
