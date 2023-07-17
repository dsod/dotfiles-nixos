{ outputs, config, lib, pkgs, ... }:

let
  # Dependencies
  jq = "${pkgs.jq}/bin/jq";
  xml = "${pkgs.xmlstarlet}/bin/xml";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  journalctl = "${pkgs.systemd}/bin/journalctl";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  playerctld = "${pkgs.playerctl}/bin/playerctld";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  btm = "${pkgs.bottom}/bin/btm";
  wofi = "${pkgs.wofi}/bin/wofi";

  terminal = "${pkgs.kitty}/bin/kitty";
  terminal-spawn = cmd: "${terminal} $SHELL -i -c ${cmd}";

  systemMonitor = terminal-spawn btm;

  # Function to simplify making waybar outputs
  jsonOutput = name: { pre ? "", text ? "", tooltip ? "", alt ? "", class ? "", percentage ? "" }: "${pkgs.writeShellScriptBin "waybar-${name}" ''
    set -euo pipefail
    ${pre}
    ${jq} -cn \
      --arg text "${text}" \
      --arg tooltip "${tooltip}" \
      --arg alt "${alt}" \
      --arg class "${class}" \
      --arg percentage "${percentage}" \
      '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
  ''}/bin/waybar-${name}";
in
{
  programs.waybar = {
    enable = true;
    settings = {

      primary = {
        layer = "top";
        height = 30;
        margin-top = 10;
        margin-bottom = 0;
        margin-right = 15;
        margin-left = 15;
        position = "top";
        modules-left = [
          "custom/menu"
          "wlr/workspaces"
          "custom/currentplayer"
          "custom/player"
        ];

        modules-center = [
          "cpu"
          "custom/gpu"
          "memory"
          "clock"
          "pulseaudio"
          "pulseaudio#microphone"
          "hyprland/language"
        ];

        modules-right = [
          "backlight"
          "battery"
          "tray"
          "custom/wallpaper"
        ];

        "backlight" = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = ["󰃞" "󰃟" "󰃠"];
          on-scroll-up = "brightnessctl set 2%+";
          on-scroll-down = "brightnessctl set 2%-";
          min-length = 6;
        };

        "wlr/workspaces" = {
          format = "";
          on-click = "activate";
        };

        "hyprland/language" = {
          format = "󰌌 {short}";
        };

        clock = {
          format = "{:%m/%d %H:%M}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
                 mode           = "year";
                 mode-mon-col   = 3;
                 weeks-pos      = "right";
                 on-scroll      = 1;
                 on-click-right = "mode";
                 format = {
                            months =     "<span color='#ffead3'><b>{}</b></span>";
                            days =       "<span color='#ecc6d9'><b>{}</b></span>";
                            weeks =      "<span color='#99ffdd'><b>W{}</b></span>";
                            weekdays =   "<span color='#ffcc66'><b>{}</b></span>";
                            today =      "<span color='#ff6699'><b><u>{}</u></b></span>";
                              };
                  };
      actions =  {
                  on-click-right = "mode";
                  on-click-forward = "tz_up";
                  on-click-backward = "tz_down";
                  on-scroll-up = "shift_up";
                  on-scroll-down = "shift_down";
                  };
        };
        cpu = {
          format = " {usage}%";
          on-click = systemMonitor;
        };

        "custom/wallpaper" = {
          format = "";
          on-click = "wpaperd";
        };

        "custom/gpu" = {
          interval = 5;
          return-type = "json";
          exec = jsonOutput "gpu" {
            text = "$(cat /sys/class/drm/card0/device/gpu_busy_percent)";
            tooltip = "GPU Usage";
          };
          format = "󰒋 {}%";
          on-click = systemMonitor;
        };
        memory = {
          format = "󰍛 {}%";
          interval = 5;
          on-click = systemMonitor;
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " 0%";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            portable = "";
            default = [ "" "" "" ];
          };
          scroll-step = 2;
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          on-click-right = "pavucontrol";
          on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -2%";
          on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +2%";
        };
        "pulseaudio#microphone" = {
          format =  "{format_source} {source_volume}%";
          format-source = "";
          format-source-muted = "";
          scroll-step = 2;
          on-click = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          on-click-right = "pavucontrol";
          on-scroll-down = "pactl set-source-volume @DEFAULT_SOURCE@ -2%";
          on-scroll-up = "pactl set-source-volume @DEFAULT_SOURCE@ +2%";
        };

        battery = {
          bat = "BAT0";
          interval = 10;
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          onclick = "";
        };
        "sway/window" = {
          max-length = 20;
        };
        network = {
          interval = 3;
          format-wifi = "  {essid}";
          format-ethernet = "󰈁 Connected";
          format-disconnected = "";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
          on-click = "";
        };
        "custom/menu" = {
          return-type = "json";
          exec = jsonOutput "menu" {
            text = "";
            tooltip = ''$(cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f2)'';
          };
          on-click = "${wofi} -S drun -x 10 -y 10 -W 25% -H 60%";
        };
        "custom/currentplayer" = {
          interval = 2;
          return-type = "json";
          exec = jsonOutput "currentplayer" {
            pre = ''
              player="$(${playerctl} status -f "{{playerName}}" 2>/dev/null || echo "No player active" | cut -d '.' -f1)"
              count="$(${playerctl} -l | wc -l)"
              if ((count > 1)); then
                more=" +$((count - 1))"
              else
                more=""
              fi
            '';
            alt = "$player";
            tooltip = "$player ($count available)";
            text = "$more";
          };
          format = "{icon}{}";
          format-icons = {
            "No player active" = " ";
            "Celluloid" = "󰎁 ";
            "spotify" = " 󰓇";
            "ncspot" = " 󰓇";
            "qutebrowser" = "󰖟";
            "firefox" = " ";
            "discord" = " 󰙯 ";
            "sublimemusic" = " ";
            "kdeconnect" = "󰄡 ";
          };
          on-click = "${playerctld} shift";
          on-click-right = "${playerctld} unshift";
        };
        "custom/player" = {
          exec-if = "${playerctl} status";
          exec = ''${playerctl} metadata --format '{"text": "{{artist}} - {{title}}", "alt": "{{status}}", "tooltip": "{{title}} ({{artist}} - {{album}})"}' '';
          return-type = "json";
          interval = 2;
          max-length = 30;
          format = "{icon} {}";
          format-icons = {
            "Playing" = "󰐊";
            "Paused" = "󰏤 ";
            "Stopped" = "󰓛";
          };
          on-click = "${playerctl} play-pause";
          on-scroll-up = "${playerctl} previous";
          on-scroll-down = "${playerctl} next";
        };
      };

    };
    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left
    style = let inherit (config.colorscheme) colors; in /* css */ ''
      * {
        font-family: ${config.fontProfiles.regular.family}, ${config.fontProfiles.monospace.family};
        font-weight: normal;
        font-size: 11pt;
        margin: 0 4px;
        padding: 0px;
      }

      window#waybar.top {
        min-height: 30px;
        padding: 0;
        background-color: rgba(36,38,58,0.5);
        color: #${colors.base05};
        border: 2px solid #${colors.base0C};
        border-radius: 10px;
      }

      #workspaces {
      }

      #workspaces button {
        min-height: 16px;
        min-width: 16px;
        font-weight: bold;
        background-color: #${colors.base01};
        color: #${colors.base05};
        border-radius: 99px;
        border: 2px solid #${colors.base03};
        margin: 7px 3px;
        padding: 0px;
      }
      #workspaces button.hidden {
        background-color: #${colors.base00};
        color: #${colors.base04};
      }
      #workspaces button.focused,
      #workspaces button.active {
        background-color: #${colors.base0E};
        border-color: #${colors.base0E};
        color: #${colors.base00};
      }

      #workspaces button.urgent {
        border-color: #${colors.base0E};
      }

      #clock {
        background-color: #${colors.base0A};
        color: #${colors.base00};
        padding: 0 15px;
        margin: 8px 8px;
        border-radius: 10px;
      }

      #custom-menu {
        background-color: #${colors.base0C};
        color: #${colors.base00};
        padding: 3px 6px;
        margin: 5px;
        margin-left: 0px;
        border-radius: 10px;
      }

      #custom-wallpaper {
        background-color: #${colors.base0C};
        color: #${colors.base00};
        padding: 3px 6px;
        margin: 5px;
        margin-right: 0px;
        border-radius: 10px;
      }

      #tray {
        color: #${colors.base05};
      }
    '';
  };
}
