{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    plasma-manager,
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations."pc" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        plasma-manager.homeManagerModules.plasma-manager
        ./home.nix
      ];
      # sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
    };

    nixosConfigurations."pc" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.bahnasawy = import ./home.nix;

          home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
        }
      ];
    };

    # packages.x86_64-linux.nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    #   system = "x86_64-linux";
    #   modules = [
    #     # Import the previous configuration.nix we used,
    #     # so the old configuration file still takes effect
    #     ./configuration.nix
    #
    #     #   home-manager.nixosModules.home-manager
    #     #   {
    #     #     home-manager.useGlobalPkgs = true;
    #     #     home-manager.useUserPackages = true;
    #     #     home-manager.backupFileExtension = "backup";
    #     #     home-manager.users.bahnasawy = import ./home.nix;
    #     #
    #     #     home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
    #     #   }
    #   ];
    # };
  };
}
