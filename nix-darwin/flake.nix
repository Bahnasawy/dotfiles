{
  description = "GoBLiN Macos configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
    let
      configuration = { pkgs, config, ... }: {


        nixpkgs.config.allowUnfree = true;

        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages =
          [
            pkgs.neovim
            pkgs.mkalias
            pkgs.zsh-prezto
            pkgs.iterm2
            pkgs.postman
            pkgs.bun
            pkgs.git
            pkgs.lazygit
            pkgs.openssh
            pkgs.home-manager
            pkgs.zoxide
            pkgs.fzf
            pkgs.nodejs_22
            pkgs.tree-sitter
            pkgs.rustup
            pkgs.neovide
            pkgs.raycast
            pkgs.lsd
            pkgs.wget
            pkgs.doppler
            pkgs.gh
          ];

        fonts.packages = [
          (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        ];

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        security.pam.enableSudoTouchIdAuth = true;

        system.defaults = {
          dock.autohide = true;
          dock.orientation = "left";
          dock.persistent-apps = [
            "/Applications/Arc.app"
            "${pkgs.neovide}/Applications/Neovide.app"
            "/System/Applications/Mail.app"
          ];
          finder.FXPreferredViewStyle = "clmv";
          finder.ShowPathbar = true;
          loginwindow.ShutDownDisabled = true;
          NSGlobalDomain.KeyRepeat = 2;
          NSGlobalDomain.AppleInterfaceStyle = "Dark";
          loginwindow.GuestEnabled = true;
          dock.dashboard-in-overlay = false;
          dock.show-recents = false;
          dock.tilesize = 48;
          WindowManager.GloballyEnabled = true;
          NSGlobalDomain."com.apple.keyboard.fnState" = true;
          NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
          NSGlobalDomain."com.apple.trackpad.enableSecondaryClick" = true;
          trackpad.TrackpadRightClick = true;
          trackpad.Clicking = true;
        };

        homebrew = {
          enable = true;
          casks = [
            "iina"
            "the-unarchiver"
            "arc"
            "android-studio"
            "bitwarden"
            "insomnia"
            "spotify"
            "notion"
            "notion-calendar"
          ];
          brews = [
            "mas"
          ];
          masApps = {
            "XCode" = 497799835;
          };
          onActivation.cleanup = "zap";
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";

        system.activationScripts.applications.text =
          let
            env = pkgs.buildEnv {
              name = "system-applications";
              paths = config.environment.systemPackages;
              pathsToLink = "/Applications";
            };
          in
          pkgs.lib.mkForce ''
            # Set up applications.
            echo "setting up /Applications..." >&2
            rm -rf /Applications/Nix\ Apps
            mkdir -p /Applications/Nix\ Apps
            find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            while read src; do
              app_name=$(basename "$src")
              echo "copying $src" >&2
              ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
          '';
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple

      darwinConfigurations."mac" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
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
              users.bahnasawy = import ./home.nix;
            };
            users.users.bahnasawy.home = "/Users/bahnasawy";
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."mac".pkgs;
    };
}
