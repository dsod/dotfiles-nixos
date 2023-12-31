{ config, pkgs, ... }:

let
  inherit (config.colorscheme) colors;
  kitty-xterm = pkgs.writeShellScriptBin "xterm" ''
    ${config.programs.kitty.package}/bin/kitty -1 "$@"
  '';
in
{
  home = {
    packages = [ kitty-xterm ];
    sessionVariables = {
      TERMINAL = "kitty -1";
    };
  };


  programs.kitty = {
    enable = true;
    font = {
      name = config.fontProfiles.monospace.family;
      size = 12;
    };

    shellIntegration = {
      enableFishIntegration = false;
      enableBashIntegration = false;
      enableZshIntegration = false;
    };

    settings = {
      allow_remote_control = true;
      listen_on = "unix:${config.xdg.cacheHome}/kitty_remote";
      scrollback_lines = 4000;
      scrollback_pager_history_size = 2048;
      window_padding_width = 15;
      foreground = "#${colors.base05}";
      background = "#${colors.base00}";
      selection_background = "#${colors.base05}";
      selection_foreground = "#${colors.base00}";
      url_color = "#${colors.base04}";
      cursor = "#${colors.base05}";
      active_border_color = "#${colors.base03}";
      inactive_border_color = "#${colors.base01}";
      active_tab_background = "#${colors.base00}";
      active_tab_foreground = "#${colors.base05}";
      inactive_tab_background = "#${colors.base01}";
      inactive_tab_foreground = "#${colors.base04}";
      tab_bar_background = "#${colors.base01}";
      color0 = "#${colors.base00}";
      color1 = "#${colors.base08}";
      color2 = "#${colors.base0B}";
      color3 = "#${colors.base0A}";
      color4 = "#${colors.base0D}";
      color5 = "#${colors.base0E}";
      color6 = "#${colors.base0C}";
      color7 = "#${colors.base05}";
      color8 = "#${colors.base03}";
      color9 = "#${colors.base08}";
      color10 = "#${colors.base0B}";
      color11 = "#${colors.base0A}";
      color12 = "#${colors.base0D}";
      color13 = "#${colors.base0E}";
      color14 = "#${colors.base0C}";
      color15 = "#${colors.base07}";
      color16 = "#${colors.base09}";
      color17 = "#${colors.base0F}";
      color18 = "#${colors.base01}";
      color19 = "#${colors.base02}";
      color20 = "#${colors.base04}";
      color21 = "#${colors.base06}";
    };
    keybindings = {
      "f1" = "launch --allow-remote-control kitty +kitten broadcast --match-tab state:focused";
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
      "ctrl+shift+l" = "next_layout";
      "ctrl+alt+enter" = "launch --cwd=current";
      "f2" = "new_window_with_cwd";
    };
  };
    xdg.configFile."kitty/ssh.conf".text = ''
      color_scheme Catppuccin-Macchiato
      copy --symlink-strategy resolve --dest .bashrc .config/kitty/.bashrc
      copy --symlink-strategy resolve --dest ~/.terminfo/xterm-kitty $TERMINFO
      env TERM=xterm-kitty
      env TERMINFO=~/.terminfo/xterm-kitty
    '';

    xdg.configFile."kitty/.bashrc".text = ''
      # Commands that should be applied only for interactive shells.
      [[ $- == *i* ]] || return

      HISTFILESIZE=100000
      HISTSIZE=10000

      shopt -s histappend
      shopt -s checkwinsize
      shopt -s extglob
      shopt -s globstar
      shopt -s checkjobs

      color_prompt=yes;

      alias sudo='sudo TERMINFO="$TERMINFO"'

      # Source global definitions
      if [ -f /etc/bashrc ]; then
        . /etc/bashrc
      fi
    '';
}
