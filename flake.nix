{

    description = "My system config";

    inputs = {

     nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
     flake-utils.url = "github:numtide/flake-utils";

     home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    };

    outputs = {
    self,
    nixpkgs,
    home-manager,
    flake-utils,
    ...
  } @ inputs: let
    outputs = self;
  in
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        # devShells.default = import ./shell.nix {inherit pkgs;};
        formatter = nixpkgs.legacyPackages.${system}.alejandra;
      }
    )
    // {
      lib = nixpkgs.lib // home-manager.lib;

    #   nixosModules = import ./modules/nixos;
    #   homeModules = import ./modules/home;
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
        home-manager.nixosModules.home-manager
                {
                    home-manager.useUserPackages = true;
                    home-manager.useGlobalPkgs = true;
                    home-manager.users.wolf4am = import ./home-manager/home.nix;
                    home-manager.backupFileExtension = "backup";
                }
        ];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };

}


