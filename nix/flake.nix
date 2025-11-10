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

    android-nixpkgs = {
      url = "github:tadfisher/android-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      android-nixpkgs,
    }@inputs:
    let
      linuxSystem = "x86_64-linux";
      linuxPackages = nixpkgs.legacyPackages.${linuxSystem};

      darwinSystem = "aarch64-darwin";
      darwinPackages = nixpkgs.legacyPackages.${darwinSystem};

      overlays = [
        neovim.overlays.default
        android-nixpkgs.overlays.default
      ];
    in
    {
      homeConfigurations = {
        pc = home-manager.lib.homeManagerConfiguration {
          pkgs = linuxPackages;

          modules = [
            plasma-manager.homeModules.plasma-manager
            ./pc/home.nix
            {
              nixpkgs.overlays = overlays;
            }
          ];
        };

        usb = home-manager.lib.homeManagerConfiguration {
          pkgs = linuxPackages;

          modules = [
            plasma-manager.homeModules.plasma-manager
            ./usb/home.nix
            {
              nixpkgs.overlays = overlays;
            }
          ];
        };

        p2 = home-manager.lib.homeManagerConfiguration {
          pkgs = linuxPackages;

          modules = [
            ./p2/home.nix
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
            plasma-manager.homeModules.plasma-manager
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
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users.bahnasawy = import ./pc/home.nix;
                extraSpecialArgs = { inherit android-nixpkgs; };

                sharedModules = [
                  plasma-manager.homeModules.plasma-manager
                ];
              };
              nixpkgs.overlays = overlays;
            }
          ];
        };

        usb = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./usb/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users.bahnasawy = import ./usb/home.nix;
                extraSpecialArgs = { inherit android-nixpkgs; };

                sharedModules = [
                  plasma-manager.homeModules.plasma-manager
                ];
              };
              nixpkgs.overlays = overlays;
            }
          ];
        };

        p2 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.default
            ./p2/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users.brandon = import ./p2/home.nix;
              };
              nixpkgs.overlays = overlays;
            }
          ];
        };

        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.default
            ./wsl/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users.bahnasawy = import ./wsl/home.nix;
              };
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
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users.bahnasawy = import ./laptop/home.nix;

                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
              };
              nixpkgs.overlays = overlays;
            }
          ];
        };
      };

      darwinModules.podman = ./mac/modules/podman.nix;
      darwinConfigurations = {
        mac = nix-darwin.lib.darwinSystem {
          modules = [
            ./mac/configuration.nix
            ./mac/modules/podman.nix

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
                extraSpecialArgs = { inherit android-nixpkgs; };
              };
              users.users.bahnasawy.home = "/Users/bahnasawy";

              nixpkgs.overlays = overlays;
            }
          ];
        };
      };
    };
}
