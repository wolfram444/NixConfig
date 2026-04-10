{
  description = "My system config";

  inputs = {
    nixpkgs.url = "git+https://git.oss.uzinfocom.uz/xinux/nixpkgs?ref=nixos-unstable&shallow=1";
    upstream.url = "github:xinux-org/upstream/updatee-e-imzo";
    # xinux-nixpkgs.url = "git+https://git.oss.uzinfocom.uz/xinux/nixpkgs?ref=nixos-unstable&shallow=1";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/";
      # inputs.upstream.follows = "nixpkgs";
    };

    xinux-modules = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/modules?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      flake-utils,
      ...
    }@inputs:
    let
      outputs = self;
    in
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = inputs.upstream.legacyPackages.${system};
      in
      {
        # devShells.default = import ./shell.nix {inherit pkgs;};
        formatter = pkgs.nixfmt;
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            self.formatter.${system}
            nixd
            nixfmt
            statix
            deadnix
          ];
        };
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
