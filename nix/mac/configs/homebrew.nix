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
      "notion-calendar"
      "notion-mail"
      "whatsapp"
      "expo-orbit"
      "raycast"
      "ghostty@tip"
      "microsoft-teams"
      "microsoft-outlook"
      "microsoft-word"
      "microsoft-excel"
      "flutter"
      "postman"
      "teamviewer"
    ];
    brews = [
      "fastlane"
      "bun"
      "libiconv"
      "tmux-fingers"
      "watchman"
      "herdr"
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
    };
  };
}
