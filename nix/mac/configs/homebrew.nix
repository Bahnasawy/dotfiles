_: {
  homebrew = {
    enable = true;
    user = "bahnasawy";
    casks = [
      "iina"
      "the-unarchiver"
      "arc"
      "spotify"
      "whatsapp"
      "expo-orbit"
      "raycast"
      "ghostty@tip"
      "microsoft-teams"
      "microsoft-outlook"
      "microsoft-word"
      "microsoft-excel"
      "postman"
      "visual-studio-code"
      "teamviewer"
      "linear"
      "handy"
    ];
    brews = [
      "fastlane"
      "bun"
      "libiconv"
      "tmux-fingers"
      "watchman"
      "purple"
    ];
    taps = [
      "oven-sh/bun"
      "morantron/tmux-fingers"
      "nubjs/tap"
      "erickochen/purple"
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
      extraEnv = {
        HOMEBREW_NO_ENV_HINTS = "1";
        HOMEBREW_NO_ANALYTICS = "1";
        HOMEBREW_NO_UPDATE_REPORT_NEW = "1";
      };
    };
  };
}
