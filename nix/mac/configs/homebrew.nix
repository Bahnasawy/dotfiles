{...}: {
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
      "whatsapp"
      "expo-orbit"
      "expressvpn"
    ];
    brews = [
      "mas"
      "fastlane"
    ];
    masApps = {
      "XCode" = 497799835;
      "Transporter" = 1450874784;
    };
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
