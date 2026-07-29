_: {
  homebrew = {
    enable = true;
    user = "bahnasawy";
    casks = [
      "iina"
      "the-unarchiver"
      "arc"
      "spotify"
      "notion"
      "whatsapp"
      "expo-orbit"
      "raycast"
      "ghostty@tip"
      "microsoft-teams"
      "microsoft-outlook"
      "microsoft-word"
      "microsoft-excel"
      "postman"
      "beekeeper-studio"
      "visual-studio-code"
      "teamviewer"
      "linear"
    ];
    brews = [
      "fastlane"
      "bun"
      "libiconv"
      "tmux-fingers"
      "watchman"
    ];
    taps = [
      "oven-sh/bun"
      "morantron/tmux-fingers"
    ];
    # masApps = {
    #   "XCode" = 497799835;
    #   "Transporter" = 1450874784;
    #   "Irvue" = 1039633667;
    #   "Testflight" = 899247664;
    # };
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      extraFlags = [ "--verbose" ];
    };
  };
}
