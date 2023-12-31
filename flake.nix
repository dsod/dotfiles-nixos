{
  description = "My NixOS configuration";

  nixConfig = {
    extra-substituters = [ "https://cache.nixos.org/" "https://hyprland.cachix.org" ];
    extra-trusted-public-keys = [ "cache.nixos.org:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg=" "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-ld-rs.url = "github:nix-community/nix-ld-rs";
    nix-ld-rs.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
      pkgsFor = nixpkgs.legacyPackages;
    in
    {
      inherit lib;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      overlays = import ./overlays { inherit inputs outputs; };

      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      nixosConfigurations = {
        # Main desktop
        dsod = lib.nixosSystem {
          modules = [ ./hosts/dsod ];
          specialArgs = { inherit inputs outputs; };
        };
        # Secondary desktop
        dsod-laptop = lib.nixosSystem {
          modules = [ ./hosts/dsod-laptop ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        # Desktops
        "dsod@dsod" = lib.homeManagerConfiguration {
          modules = [ ./home/dsod/dsod.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "dsod@dsod-laptop" = lib.homeManagerConfiguration {
          modules = [ ./home/dsod/dsod-laptop.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
