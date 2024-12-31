{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
    grub.device = "nodev";
    grub.efiSupport = true;
  };

  hardware = {
    bluetooth.enable = true; # enables support for Bluetooth
    bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  services.blueman.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    xserver = {
      enable = true;
    };
    displayManager = {
      sddm.enable = false;
      sddm.wayland.enable = true;
      sddm.settings.General.DisplayServer = "x11-user";
    };
    desktopManager.plasma6.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
      extraConfig.pipewire.adjust-sample-rate = {
        "context.properties" = {
          "default.clock.rate" = 44100;
          "defautlt.allowed-rates" = [44100 48000];
        };
      };
    };
    openssh = {
      enable = true;
    };
    postgresql = {
      enable = true;
      ensureDatabases = ["bahnasawy" "eshop"];
      ensureUsers = [
        {
          name = "bahnasawy";
          ensureDBOwnership = true;
          ensureClauses = {
            superuser = true;
            createrole = true;
            createdb = true;
            login = true;
          };
        }
      ];
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
        host all       all     127.0.0.1/32 md5
      '';
      initialScript = pkgs.writeText "backend-initScript" ''
        REVOKE ALL ON DATABASE eshop FROM bahnasawy;
        GRANT CONNECT ON DATABASE eshop TO bahnasawy;
        GRANT SELECT ON ALL TABLES IN SCHEMA public TO bahnasawy;
        GRANT INSERT ON ALL TABLES IN SCHEMA public TO bahnasawy;
        GRANT UPDATE ON ALL TABLES IN SCHEMA public TO bahnasawy;
        ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO bahnasawy;
        ALTER DATABASE eshop SET search_path TO bahnasawy;
      '';
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.kernelParams = [
    "video=DP-1:2560x1440@170"
    "video=HDMI-A-1:1920x1080@60"
  ];

  programs = {
    adb.enable = true;
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      gradle_8
      aapt
      lua-language-server
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages
    ];
  };

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  environment.defaultPackages = with pkgs; [
    # neovim
  ];

  nix = {
    enable = true;
    settings.max-jobs = 64;
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };
}
