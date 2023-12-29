{ pkgs, config, lib, ... }:

with lib;

let
  cfg = config.services.pass-secret-service;
  passService = "${cfg.package}/bin/pass_secret_service";
  execServiceArgs = "${lib.escapeShellArgs cfg.extraArgs}";
  execService = "${passService} ${execServiceArgs}";
in {
  disabledModules = [ "services/pass-secret-service.nix" ];

  meta.maintainers = with maintainers; [ cab404 cyntheticfox ];

  options.services.pass-secret-service = {
    enable = mkEnableOption "Pass libsecret service";

    package = mkPackageOption pkgs "pass-secret-service" { };

    storePath = mkOption {
      type = with types; nullOr str;
      default = null;
      defaultText = "~/.password-store";
      example = "/home/user/.local/share/password-store";
      description = "Absolute path to password store.";
    };

    extraArgs = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ ];
      description = "Extra command-line arguments to be passed to the service.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      (hm.assertions.assertPlatform "services.pass-secret-service" pkgs
        platforms.linux)
    ];

    services.pass-secret-service.extraArgs = optional (cfg.storePath != null) "--path=${cfg.storePath}";

    systemd.user.services = {
      pass-secret-service = {
        Unit = {
          AssertFileIsExecutable = "${passService}";
          Description = "Pass libsecret service";
          Documentation = "https://github.com/mdellweg/pass_secret_service";
          PartOf = [ "default.target" ];
        };

        Service = {
          ExecStart = execService;
        };

        Install = { WantedBy = [ "default.target" ]; };
      };

      "dbus-org.freedesktop.secrets" = {
        Unit = {
          AssertFileIsExecutable = "${passService}";
          Description = "Expose the libsecret dbus api with pass as backend";
        };

        Service = {
          BusName = "org.freedesktop.secrets";
          ExecStart = execService;
        };
      };
    };

  };

}
