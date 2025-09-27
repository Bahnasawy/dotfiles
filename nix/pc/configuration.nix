{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./configs/system.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  users.users.bahnasawy = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "kvm"
      "adbusers"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.nushell;
  };

  users.defaultUserShell = pkgs.nushell;

  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';

  services.udev.extraRules = ''
    # Remove NVIDIA USB xHCI Host Controller devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA USB Type-C UCSI devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA Audio devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA VGA/3D controller devices
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  '';
  boot.blacklistedKernelModules = [
    "nouveau"
    "nvidia"
    "nvidia_drm"
    "nvidia_modeset"
  ];

  system.stateVersion = "24.11";

  environment.defaultPackages = with pkgs; [ networkmanager ];
  networking.hostName = "pc";
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    dive
    podman-tui
    docker-compose
  ];

  time.timeZone = "Africa/Cairo";
}
