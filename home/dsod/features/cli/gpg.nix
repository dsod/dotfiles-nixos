{ pkgs, config, lib, ... }:
let
  pinentry =
    if config.gtk.enable then {
      packages = [ pkgs.pinentry-gnome pkgs.gcr ];
      name = "gnome3";
    } else {
      packages = [ pkgs.pinentry-curses ];
      name = "curses";
    };
in
{
  home.packages = pinentry.packages;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ "B4DC7FB6F76CE29D06A858AD8AAC27A5744B6CD5" "A94BBC5EBD961383E7617546DFA011F89CB302FA" ];
    pinentryFlavor = pinentry.name;
    enableExtraSocket = true;
    defaultCacheTtl = 60 * 60 * 2;
    defaultCacheTtlSsh = 60 * 60 * 2;
  };

  programs =
    let
      fixGpg = ''
        gpgconf --launch gpg-agent
      '';
    in
    {
      # Start gpg-agent if it's not running or tunneled in
      # SSH does not start it automatically, so this is needed to avoid having to use a gpg command at startup
      # https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
      bash.profileExtra = fixGpg;
      fish.loginShellInit = fixGpg;
      zsh.loginExtra = fixGpg;

      gpg = {
        enable = true;
        settings = {
          trust-model = "tofu+pgp";
        };
      };
    };

  systemd.user.services = {
    # Link /run/user/$UID/gnupg to ~/.gnupg-sockets
    # So that SSH config does not have to know the UID
    link-gnupg-sockets = {
      Unit = {
        Description = "link gnupg sockets from /run to /home";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
        ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
        RemainAfterExit = true;
      };
      Install.WantedBy = [ "default.target" ];
    };
  };

  home.file.".ssh/config".text = ''
    Host *
      User dsod
      IdentityFile ~/.ssh/id_rsa

    Host github.com
      IdentityFile ~/.ssh/id_ed25519
      HostName github.com

    # AWS CoopNO Staging
    Host coopno-staging-bastion
      ForwardAgent yes
      HostName 13.50.215.205

    # AWS Staging
    Host shared-staging-bastion
      ForwardAgent yes
      HostName 13.50.187.102

    # AWS Coop NO Staging
    Host coopno-staging-bastion
      ForwardAgent yes
      HostName 13.50.215.205

    # AWS Production
    Host shared-prod-bastion
      ForwardAgent yes
      HostName 16.171.20.144

    # AWS CoopNO Production
    Host coopno-prod-bastion
      ForwardAgent yes
      HostName 13.51.107.121

    # AWS Ericsson Production
    Host ers-prod-bastion
      ForwardAgent yes
      HostName 16.16.26.88

    # AWS Ericsson Staging
    Host ers-staging-bastion
      ForwardAgent yes
      HostName 16.170.58.178

    # QBNK dev
    Host shared-dev-bastion
      ForwardAgent yes
      HostName 13.48.117.77

    # Cleura
    Host cleura-bastion
      HostName 188.240.223.149
      ForwardAgent yes

    Host cleura-web01
      HostName 10.15.0.99
      ProxyJump cleura-bastion

    Host cleura-web02
      HostName 10.15.0.116
      ProxyJump cleura-bastion

    Host cleura-worker01
      HostName 10.15.0.129
      ProxyJump cleura-bastion

    Host cleura-callback01
      HostName 10.15.0.159
      ProxyJump cleura-bastion

    Host cleura-nfs01
      HostName 10.15.0.53
      ProxyJump cleura-bastion

    Host cleura-redis01
      HostName 10.15.0.108
      ProxyJump cleura-bastion

    Host cleura-redis02
      HostName 10.15.0.175
      ProxyJump cleura-bastion

    Host cleura-redis03
      HostName 10.15.0.177
      ProxyJump cleura-bastion

    Host cleura-elasticsearch01
      HostName 10.15.0.126
      ProxyJump cleura-bastion

    Host cleura-elasticsearch02
      HostName 10.15.0.173
      ProxyJump cleura-bastion

    Host cleura-elasticsearch03
      HostName 10.15.0.171
      ProxyJump cleura-bastion

    Host cleura-postgresql01
      HostName 10.15.0.157
      ProxyJump cleura-bastion

    Host cleura-mediaportal01
      HostName 10.15.0.62
      ProxyJump cleura-bastion

    Host cleura-mediaportal02
      HostName 10.15.0.12
      ProxyJump cleura-bastion
  '';
}
# vim: filetype=nix
