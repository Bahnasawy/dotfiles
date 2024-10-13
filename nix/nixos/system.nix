{ config, lib, pkgs, ... }:
{
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
      sddm.enable = true;
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
}
