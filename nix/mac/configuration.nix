{pkgs, ...}: {
  imports = [
    ./configs/homebrew.nix
    ./configs/system.nix
  ];

  nixpkgs.config.allowUnfree = true;

  fonts.packages = [
    (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  nix.settings.experimental-features = "nix-command flakes";

  # system.configurationRevision = self.rev or self.dirtyRev or null;

  nixpkgs.hostPlatform = "aarch64-darwin";
}
