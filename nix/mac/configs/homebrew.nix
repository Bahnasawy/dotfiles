_: {
  homebrew = {
    enable = true;
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
      "ghostty@tip"
      "shortcat"
      "transmission"
      "raycast"
      "handbrake-app"
      "microsoft-teams"
      "microsoft-outlook"
      "microsoft-word"
      "microsoft-excel"
      "flutter"
      "inkscape"
      "postman"
      "teamviewer"
    ];
    brews = [
      "mas"
      "fastlane"
      "bun"
      "libiconv"
      "minio-mc"
      "tmux-fingers"
      "watchman"
    ];
    taps = [
      "oven-sh/bun"
      "morantron/tmux-fingers"
    ];
    masApps = {
      # "XCode" = 497799835;
      # "Transporter" = 1450874784;
      # "Irvue" = 1039633667;
      # "Testflight" = 899247664;
    };
    global = {
      autoUpdate = false;
    };
    onActivation = {
      # cleanup = "zap";
      autoUpdate = true;
      # upgrade = true;
      # extraFlags = [ "--verbose" ];
    };
  };
}
