_: {
  homebrew = {
    enable = true;
    casks = [
      "iina"
      "the-unarchiver"
      "arc"
      "bitwarden"
      "spotify"
      "notion"
      "notion-calendar"
      "notion-mail"
      "whatsapp"
      "expo-orbit"
      "ghostty@tip"
      "shortcat"
      "transmission"
      "raycast"
      "zen"
      "handbrake-app"
      "virtualbox"
    ];
    brews = [
      "mas"
      "fastlane"
      "bun"
      "libiconv"
      "minio-mc"
    ];
    taps = [
      "oven-sh/bun"
    ];
    masApps = {
      "XCode" = 497799835;
      "Transporter" = 1450874784;
      "GP Calendar" = 1632951751;
      "Screenshot Monitor" = 1336124970;
      "Blackmagic Disk Speed Test" = 425264550;
    };
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
      # extraFlags = [ "--verbose" ];
    };
  };
}
