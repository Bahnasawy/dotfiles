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
    };
  };

  programs.zsh.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.kernelParams = [
    "video=DP-1:2560x1440@170"
    "video=HDMI-A-1:1920x1080@60"
  ];

  programs.adb.enable = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  fonts.packages = [
    (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    gradle_8
    aapt
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
}
