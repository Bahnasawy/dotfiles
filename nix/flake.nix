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
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    plasma-manager,
    nix-darwin,
    nix-homebrew,
  } @ inputs: let
    linuxSystem = "x86_64-linux";
    linuxPackages = import nixpkgs {inherit linuxSystem;};

    darwinSystem = "aarch64-darwin";
    darwinPackages = import nixpkgs {inherit darwinSystem;};
  in {
    homeConfigurations = {
      pc = home-manager.lib.homeManagerConfiguration {
        inherit linuxPackages;

        modules = [
          plasma-manager.homeManagerModules.plasma-manager
          ./pc/home.nix
        ];
      };

      laptop = home-manager.lib.homeManagerConfiguration {
        inherit linuxPackages;

        modules = [
          plasma-manager.homeManagerModules.plasma-manager
          ./laptop/home.nix
        ];
      };

      mac = home-manager.lib.homeManagerConfiguration {
        inherit darwinPackages;

        modules = [
          ./mac/home.nix
        ];
      };
    };

    nixosConfigurations = {
      pc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./pc/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.bahnasawy = import ./pc/home.nix;

            home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
          }
        ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./laptop/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.bahnasawy = import ./laptop/home.nix;

            home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
          }
        ];
      };
    };

    darwinConfigurations = {
      mac = nix-darwin.lib.darwinSystem {
        modules = [
          ./mac/configuration.nix

          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "bahnasawy";
            };
          }

          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.bahnasawy = import ./mac/home.nix;
            };
            users.users.bahnasawy.home = "/Users/bahnasawy";
          }
        ];
      };
    };
  };
}
