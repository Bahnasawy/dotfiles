{ ... }:
{
  homebrew = {
    enable = true;
    casks = [
      "iina"
      "the-unarchiver"
      "arc"
      "bitwarden"
      "insomnia"
      "spotify"
      "notion"
      "notion-calendar"
      "notion-mail"
      "whatsapp"
      "expo-orbit"
      "expressvpn"
      "zed"
      "ghostty@tip"
      "shortcat"
      "beekeeper-studio"
      "transmission"
      "microsoft-remote-desktop"
      "raycast"
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
    };
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
