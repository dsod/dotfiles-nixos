{ outputs, inputs }:
let
  addPatches = pkg: patches: pkg.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ patches;
  });
in {
  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}' or
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs
      (_: flake: (flake.legacyPackages or flake.packages or { }).${final.system} or { })
      inputs;
  };

  # Adds my custom packages
  additions = final: prev: import ../pkgs { pkgs = final; } // {
    formats = prev.formats // import ../pkgs/formats { pkgs = final; };
    vimPlugins = prev.vimPlugins // final.callPackage ../pkgs/vim-plugins { };
  };

  # Modifies existing packages
  modifications = final: prev: {

    passExtensions = prev.passExtensions // {
      # https://github.com/tadfisher/pass-otp/pull/173
      pass-otp = addPatches prev.passExtensions.pass-otp [ ./pass-otp-fix-completion.patch ];
    };

    # https://github.com/mdellweg/pass_secret_service/pull/37
    pass-secret-service = addPatches prev.pass-secret-service [ ./pass-secret-service-native.diff ];

     xdg-utils-spawn-terminal = addPatches prev.xdg-utils [ ./xdg-open-spawn-terminal.diff ];

  };
}
