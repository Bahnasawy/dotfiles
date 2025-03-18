{
  description = "GnArLyGoBLiN's configuration";

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
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      nix-darwin,
      nix-homebrew,
      neovim,
    nixos-wsl,
    }@inputs:
    let
      linuxSystem = "x86_64-linux";
      linuxPackages = nixpkgs.legacyPackages.${linuxSystem};

      darwinSystem = "aarch64-darwin";
      darwinPackages = nixpkgs.legacyPackages.${darwinSystem};

      overlays = [
        neovim.overlays.default
      ];
    in
    {
      homeConfigurations = {
        pc = home-manager.lib.homeManagerConfiguration {
          pkgs = linuxPackages;

          modules = [
            plasma-manager.homeManagerModules.plasma-manager
            ./pc/home.nix
            {
              nixpkgs.overlays = overlays;
            }
          ];
        };

        wsl = home-manager.lib.homeManagerConfiguration {
          pkgs = linuxPackages;

          modules = [
            ./wsl/home.nix
            {
              nixpkgs.overlays = overlays;
            }
          ];
        };

        laptop = home-manager.lib.homeManagerConfiguration {
          pkgs = linuxPackages;

          modules = [
            plasma-manager.homeManagerModules.plasma-manager
            ./laptop/home.nix
            {
              nixpkgs.overlays = overlays;
            }
          ];
        };

        mac = home-manager.lib.homeManagerConfiguration {
          pkgs = darwinPackages;

          modules = [
            ./mac/home.nix
            {
              nixpkgs.overlays = overlays;
            }
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

              home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
              nixpkgs.overlays = overlays;
            }
          ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.default ./wsl/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.bahnasawy = import ./wsl/home.nix;
              nixpkgs.overlays = overlays;
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

              home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
              nixpkgs.overlays = overlays;
            }
          ];
        };
      };

      darwinModules.podman = ./mac/modules/podman.nix;
      darwinConfigurations = {
        mac = nix-darwin.lib.darwinSystem {
          # specialArgs = {inherit inputs self;};

          modules = [
            ./mac/configuration.nix

            ./mac/modules/podman.nix

            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                # enableRosetta = true;
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
              nixpkgs.overlays = overlays;
            }
          ];
        };
      };
    };
}
