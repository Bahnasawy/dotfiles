{pkgs, ...}: {
  programs.plasma = {
    enable = true;
    workspace = {
      colorScheme = "BreezeDark";
      theme = "breeze-dark";
      lookAndFeel = "org.kde.breezedark.desktop";
    };
    input = {
      keyboard = {
        layouts = [
          {
            layout = "us";
          }
          {
            layout = "ar";
          }
        ];
      };
    };
    powerdevil.AC = {
      autoSuspend.action = "nothing";
      autoSuspend.idleTimeout = null;
      dimDisplay = {
        enable = false;
        idleTimeout = null;
      };
      powerButtonAction = "turnOffScreen";
      turnOffDisplay. idleTimeout = null;
    };
    krunner = {
      activateWhenTypingOnDesktop = true;
      position = "center";
    };
    workspace.wallpaperPictureOfTheDay = {provider = "apod";};
    panels = [];
  };
}
