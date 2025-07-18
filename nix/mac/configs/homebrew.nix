{ ... }:
{
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
      {
        name = "shortcat";
        greedy = true;
      }
      "transmission"
      "raycast"
      "zen"
      "handbrake-app"
      "windows-app"
    ];
    brews = [
      "mas"
      "fastlane"
      "bun"
      "libiconv"
    ];
    taps = [
      "oven-sh/bun"
    ];
    masApps = {
      "XCode" = 497799835;
      "Transporter" = 1450874784;
      "GP Calendar" = 1632951751;
      "Screenshot Monitor" = 1336124970;
    };
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
