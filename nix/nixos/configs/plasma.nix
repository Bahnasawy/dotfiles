{...}: {
  programs.plasma = {
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
  };
}
