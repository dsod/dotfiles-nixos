{ home, colorscheme }:
let
  inherit (home.sessionVariables) TERMINAL BROWSER EDITOR;
in
''
    monitor=,preferred,auto,auto
    monitor=desc:Samsung Electric Company C27HG7x HTHK900737, 2560x1440@144, auto, auto
    monitor=desc:Samsung Electric Company C34H89x HTOM900062, 3440x1440@100, auto, auto
    monitor=desc:Samsung Electric Company SyncMaster H1AK500000,preferred,auto,auto,mirror,eDP-1

  general {
    sensitivity=0.5
    gaps_in=10
    gaps_out=15
    border_size=2.7
    col.active_border=0xff${colorscheme.colors.base0C}
    col.inactive_border=0xff${colorscheme.colors.base02}
    col.nogroup_border_active=0xff${colorscheme.colors.base0B}
    col.nogroup_border=0xff${colorscheme.colors.base04}
    allow_tearing=true
  }

    decoration {
      active_opacity=0.94
      inactive_opacity=0.84
      fullscreen_opacity=1.0
      rounding=5
      drop_shadow=true
      shadow_range=12
      shadow_offset=3 3
      col.shadow=0x44000000
      col.shadow_inactive=0x66000000

      blur {
        enabled=true
        passes=3
        ignore_opacity=true
        size=5
      }

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
      vfr=off
      vrr=0
      no_direct_scanout=false
      key_press_enables_dpms=true
      mouse_move_enables_dpms=true
    }

    input {
      force_no_accel=true
      kb_layout=us,se
      kb_options = grp:alt_caps_toggle,caps:super
      follow_mouse=2
      accel_profile=flat
      repeat_delay = 300
      repeat_rate = 80
      natural_scroll = no
      touchpad {
        scroll_factor = 0.5
        disable_while_typing=false
      }
    }

    device:dell097d:00-04f3:311c-touchpad {
      sensitivity = 0
  }

    # Startup
    exec-once = blueman-applet
    exec-once = nm-applet --indicator
    exec-once = waybar
    exec-once = mako
    exec-once = swayidle -w
    exec-once = wpaperd
    exec-once = hyprctl setcursor Catppuccin-Macchiato-Dark-Cursors 24
    exec-once = cliphist wipe && wl-paste --type text --watch cliphist store #Stores only text data
    exec-once = wl-paste --type image --watch cliphist store #Stores only image data

    # Window rules
    windowrule=workspace 2 silent,google-chrome-stable
    windowrule=workspace 5 silent,slack
    windowrule=workspace 5 silent,spotify

    windowrule=float,blueman
    windowrule=float,nm-connection-editor
    windowrule=float,pavucontrol
    windowrule=float,thunar
    windowrulev2 = fullscreen, class:^(cs2)$
    windowrulev2 = immediate, class:^(cs2)$

    windowrulev2 = float, class:^(obsidian)$

    # Auto-start
    exec-once=[workspace 1 silent] kitty
    exec-once=[workspace 2 silent] google-chrome-stable
    exec-once=[workspace 5 silent] slack
    exec-once=[workspace 5 silent] discord
    exec-once=[workspace 5 silent] spotify
    exec-once=[workspace scratchpad silent] obsidian

    # Lid switches
   # bindl =,switch:on:Lid Switch,exec,hyprctl keyword monitor "eDP-1, disable"
   # bindl =,switch:off:Lid Switch,exec,hyprctl keyword monitor "eDP-1, preferred,auto,auto"

    $hyprutils = ~/scripts/hypr_util

    # Mouse binding
    bindm=SUPER,mouse:272,movewindow
    bindm=SUPER,mouse:273,resizewindow

    # Program bindings
    bind=SUPER,q,exec,${TERMINAL}
    bind=SUPER,w,killactive
    bind=SUPER,e,exec, bash $HOME/.config/rofi/bin/browser --recursive ~/dev .git nvim
    bind=SUPER,b,exec,${BROWSER}
    bind=SUPER,x,exec,thunar

    bind=SUPER,space,exec,sh $HOME/.config/rofi/bin/launcher
    bind=SUPER,a,exec,$HOME/.config/rofi/bin/aws --listEc2 qbnk-prod
    bind=SUPERSHIFT,a,exec, sh $HOME/.config/rofi/bin/aws --listEc2 qbnk-staging
    bind=SUPERCTRL,a,exec, sh $HOME/.config/rofi/bin/aws --listEc2 qbnk-dev
    bind=SUPER,p,exec, sh $HOME/.config/rofi/bin/powermenu
    bind=SUPER,s,exec,rofi-pass
    bind=SUPER,D,exec,rofi-bw --listAll
    bind=SUPER,v,exec, cliphist list | rofi -x11 -theme $HOME/.config/rofi/config/dmenu -dmenu -p "Search..." | cliphist decode | wl-copy
    bind=SUPER,c,exec,hyprpicker -a

    # Scratchpad
    bind = SUPER, r, exec, scratchpad
    bind = SUPERSHIFT, r, exec, scratchpad -g

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
    bind=,XF86MonBrightnessUp,exec,light -A 5
    bind=,XF86MonBrightnessDown,exec,light -U 5

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

    bind = SUPERSHIFT, 1, movetoworkspace, 1
    bind = SUPERSHIFT, 2, movetoworkspace, 2
    bind = SUPERSHIFT, 3, movetoworkspace, 3
    bind = SUPERSHIFT, 4, movetoworkspace, 4
    bind = SUPERSHIFT, 5, movetoworkspace, 5
    bind = SUPERSHIFT, 6, movetoworkspace, 6
    bind = SUPERSHIFT, 7, movetoworkspace, 7
    bind = SUPERSHIFT, 8, movetoworkspace, 8
    bind = SUPERSHIFT, 9, movetoworkspace, 9
    bind = SUPERSHIFT, 0, movetoworkspace, 10

    bind = SUPERSHIFT, mouse_down, movecurrentworkspacetomonitor, -1
    bind = SUPERSHIFT, mouse_up, movecurrentworkspacetomonitor, +1

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
