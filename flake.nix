{
  description = "My system config";

  inputs = {
    nixpkgs.url = "git+https://git.oss.uzinfocom.uz/xinux/nixpkgs?ref=nixos-unstable&shallow=1";
    # xinux-nixpkgs.url = "git+https://git.oss.uzinfocom.uz/xinux/nixpkgs?ref=nixos-unstable&shallow=1";
    # flake-utils.url = "github:numtide/flake-utils";
    nix-cachyos-kernel.url = "git+https://git.oss.uzinfocom.uz/mirrors/nix-cachyos-kernel?ref=release&shallow=1";

    home-manager = {
      url = "git+https://git.oss.uzinfocom.uz/mirrors/home-manager.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets management
    sops-nix = {
      url = "git+https://git.oss.uzinfocom.uz/mirrors/sops-nix.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xinux-modules = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/modules?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Xinux
    nix-data = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/nix-data?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xinux-settings = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/settings?ref=main&shallow=1";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    bluer.url = "git+https://git.oss.uzinfocom.uz/bleur/bleur?ref=main&shallow=1";

    snowfall-lib = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/lib?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    opensearch-dashboard.url = "github:wolfram444/OpenSearch-Dashboards?ref=test_feat";

    #Penpot
    penpot.url = "github:wolfram444/penpot-nix";

  };

  outputs =
    inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      channels-config = {
        # Allow unfree packages.
        allowUnfree = true;
        allowUnsupportedSystem = true;

      };

      # Extra nix flags to set
      outputs-builder = channels: {
        formatter = channels.nixpkgs.nixfmt-tree;
      };

      # Add modules to all NixOS systems.
      systems.modules.nixos = with inputs; [
        nix-data.nixosModules.nix-data

        xinux-modules.nixosModules.efiboot

        xinux-modules.nixosModules.meta

      ];

      # Configure Snowfall Lib, all of these settings are optional.
      snowfall = {
        namespace = "wolfram";
        meta = {
          name = "nix-config";
          title = "My new Flake";
        };
      };
    };

}

# Legacy code, Qora o'tmishdan

# outputs =
#   {
#     self,
#     nixpkgs,
#     home-manager,
#     flake-utils,
#     ...
#   }@inputs:
#   let
#     outputs = self;
#   in
#   flake-utils.lib.eachDefaultSystem (
#     system:
#     let
#       pkgs = nixpkgs.legacyPackages.${system};
#     in
#     {
#       # devShells.default = import ./shell.nix {inherit pkgs;};
#       formatter = pkgs.nixfmt;
#       devShells.default = pkgs.mkShell {
#         packages = with pkgs; [
#           self.formatter.${system}
#           nixd
#           nixfmt
#           statix
#           deadnix
#         ];
#       };
#     }
#   )
#   // {
#     lib = nixpkgs.lib // home-manager.lib;

#     #   nixosModules = import ./modules/nixos;
#     #   homeModules = import ./modules/home;
#     nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
#       system = "x86_64-linux";
#       modules = [
#         ./nixos/configuration.nix
#         home-manager.nixosModules.home-manager
#         {
#           home-manager.useUserPackages = true;
#           home-manager.useGlobalPkgs = true;
#           home-manager.users.wolf4am = import ./home-manager/home.nix;
#           home-manager.backupFileExtension = "backup";
#         }
#       ];
#       specialArgs = {
#         inherit inputs outputs;
#       };
#     };
#   };

# JavaScr*pt code detected!!!!!!!!!!!!! viu viu

# function eachDefaultSystem (outputs) {
#   const systems = [x86_64-linux, aarch64-darwin];

#   const result = {}
#   for system in systems {
#     result.append(outputs(system))
#   }

#   return result
# }

# eachDefaultSystem((system) => {
#   formatter = pkgs.nixfmt;
#       devShells.default = pkgs.mkShell {
#         packages = with pkgs; [
#           self.formatter.${system}
#           nixd
#           nixfmt
#           statix
#           deadnix
#         ];
#       };
# })
