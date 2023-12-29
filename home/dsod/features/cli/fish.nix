{ pkgs, lib, config, qbankPath, ... }:
let
  inherit (lib) mkIf;
  hasPackage = pname: lib.any (p: p ? pname && p.pname == pname) config.home.packages;
  hasRipgrep = hasPackage "ripgrep";
  hasEza = hasPackage "eza";
  hasNeovim = config.programs.neovim.enable;
  hasVscode = config.programs.vscode.enable;
  hasEmacs = config.programs.emacs.enable;
  hasNeomutt = config.programs.neomutt.enable;
  hasShellColor = config.programs.shellcolor.enable;
  hasKitty = config.programs.kitty.enable;
  shellcolor = "${pkgs.shellcolord}/bin/shellcolor";
  portalSpawner = "${qbankPath}/mediaportal-docker-environment";
  qbank = "${qbankPath}/docker-compose-qbank3";
in
{
  programs.fish = {
    enable = true;
    shellAbbrs = rec {
      jqless = "jq -C | less -r";

      n = "nix";
      nd = "nix develop -c $SHELL";
      ns = "nix shell";
      nsn = "nix shell nixpkgs#";
      nb = "nix build";
      nbn = "nix build nixpkgs#";
      nf = "nix flake";

      nr = "nixos-rebuild --flake ~/dotfiles";
      nrs = "nixos-rebuild --flake ~/dotfiles switch";
      snr = "sudo nixos-rebuild --flake ~/dotfiles";
      snrs = "sudo nixos-rebuild --flake ~/dotfiles switch";
      hm = "home-manager --flake ~/dotfiles";
      hms = "home-manager --flake ~/dotfiles switch";

      ls = mkIf hasEza "eza";

      e = mkIf hasEmacs "emacsclient -t";

      vrg = mkIf (hasNeomutt && hasRipgrep) "nvimrg";
      vim = mkIf hasNeovim "nvim";
      vi = vim;
      v = vim;

      c = mkIf hasVscode "code-insiders";

      cik = mkIf hasKitty "clone-in-kitty --type os-window";
      ck = cik;
    };
    shellAliases = {
      # Clear screen and scrollback
      clear = "printf '\\033[2J\\033[3J\\033[1;1H'";

      # Docker compose aliases
      dcu = "docker compose up -d";
      dcd = "docker compose down";

      # Portal spawner aliases
      psdcu = "docker compose -f ${portalSpawner}/docker-compose.yml up -d";
      psdcd = "docker compose -f ${portalSpawner}/docker-compose.yml down";

      # QBank aliases
      qbdcu = "docker compose -f ${qbank}/docker-compose.yml up -d";
      qbdcd = "docker compose -f ${qbank}/docker-compose.yml down";
      qbpsalm = "docker compose -f ${qbank}/docker-compose.yml exec phpfpm /bin/sh -c '/qbank3/vendor/bin/psalm.phar --root=/qbank3/ --no-cache'";
      qbda = "docker compose -f ${qbank}/docker-compose.yml exec phpfpm /bin/sh -c 'cd /qbank3 && composer dumpautoload'";
      qbci = "docker compose -f ${qbank}/docker-compose.yml exec phpfpm /bin/sh -c 'cd /qbank3 && composer install'";
      qbmig = "docker compose -f ${qbank}/docker-compose.yml exec phpfpm /bin/sh -c 'php /qbank3/app/console.php qbank:dbrevision -e development -c qbank-dev.localhost'";
      qbmiginit = "docker compose -f ${qbank}/docker-compose.yml exec phpfpm /bin/sh -c 'php /qbank3/app/console.php qbank:setup -e development -c qbank-dev.localhost'";
      qbtranslate = "docker compose -f ${qbank}/docker-compose.yml exec phpfpm /bin/sh -c 'php /qbank3/app/console.php gettext:compile'";
      ssh = "kitten ssh";
    };
    functions = {
      # Disable greeting
      fish_greeting = "";
      # Grep using ripgrep and pass to nvim
      nvimrg = mkIf (hasNeomutt && hasRipgrep) "nvim -q (rg --vimgrep $argv | psub)";
      # Integrate ssh with shellcolord
    };
    interactiveShellInit =
      # Open command buffer in vim when alt+e is pressed
      ''
        bind \ee edit_command_buffer
      '' +
      # kitty integration
      ''
        set --global KITTY_INSTALLATION_DIR "${pkgs.kitty}/lib/kitty"
        set --global KITTY_SHELL_INTEGRATION enabled
        source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
        set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
      '' +
      # Use vim bindings and cursors
      ''
        fish_vi_key_bindings
        set fish_cursor_default     block      blink
        set fish_cursor_insert      line       blink
        set fish_cursor_replace_one underscore blink
        set fish_cursor_visual      block
      '' +
      # Use terminal colors
      ''
        set -U fish_color_autosuggestion      brblack
        set -U fish_color_cancel              -r
        set -U fish_color_command             brgreen
        set -U fish_color_comment             brmagenta
        set -U fish_color_cwd                 green
        set -U fish_color_cwd_root            red
        set -U fish_color_end                 brmagenta
        set -U fish_color_error               brred
        set -U fish_color_escape              brcyan
        set -U fish_color_history_current     --bold
        set -U fish_color_host                normal
        set -U fish_color_match               --background=brblue
        set -U fish_color_normal              normal
        set -U fish_color_operator            cyan
        set -U fish_color_param               brblue
        set -U fish_color_quote               yellow
        set -U fish_color_redirection         bryellow
        set -U fish_color_search_match        'bryellow' '--background=brblack'
        set -U fish_color_selection           'white' '--bold' '--background=brblack'
        set -U fish_color_status              red
        set -U fish_color_user                brgreen
        set -U fish_color_valid_path          --underline
        set -U fish_pager_color_completion    normal
        set -U fish_pager_color_description   yellow
        set -U fish_pager_color_prefix        'white' '--bold' '--underline'
        set -U fish_pager_color_progress      'brwhite' '--background=cyan'
      '';
  };
}
