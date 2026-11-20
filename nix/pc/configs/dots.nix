{ config, ... }: {
  home.file = {
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/kitty;
      recursive = true;
    };

    ".config/opencode" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/opencode;
      recursive = true;
    };

    ".config/sesh" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/sesh;
      recursive = true;
    };

    ".config/neovide" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/neovide;
      recursive = true;
    };

    ".config/ghostty" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/ghostty;
      recursive = true;
    };

    ".config/btop" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/btop;
      recursive = true;
    };

    ".config/herdr" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/herdr;
      recursive = true;
    };

    ".config/tuios" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/tuios;
      recursive = true;
    };

    ".config/tuicr" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/tuicr;
      recursive = true;
    };

    ".config/gh-dash" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/gh-dash;
      recursive = true;
    };

    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/nvim;
      recursive = true;
    };

    ".config/tmux" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/tmux;
      recursive = true;
    };

    ".config/atuin" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/atuin;
      recursive = true;
    };

    ".config/bat" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/bat;
      recursive = true;
    };

    # ".config/git" = {
    #   source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/git;
    #   recursive = true;
    # };

    ".config/yazi" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/yazi;
      recursive = true;
    };

    # Plasma rice: per-file links, Plasma keeps these loose in ~/.config.
    ".config/kdeglobals".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/plasma/kdeglobals;
    ".config/kwinrc".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/plasma/kwinrc;
    ".config/kwinrulesrc".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/plasma/kwinrulesrc;
    ".config/plasmarc".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/plasma/plasmarc;
    ".config/plasmashellrc".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/plasma/plasmashellrc;
    ".config/plasma-org.kde.plasma.desktop-appletsrc".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/plasma/plasma-org.kde.plasma.desktop-appletsrc;
    ".config/kcminputrc".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/plasma/kcminputrc;
    ".config/kxkbrc".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/plasma/kxkbrc;
    ".config/powerdevilrc".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/plasma/powerdevilrc;
    ".config/kscreenlockerrc".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/plasma/kscreenlockerrc;
    ".config/darklyrc".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/plasma/darklyrc;
    # gtk-3.0/gtk.css and gtk-4.0/gtk.css are NOT linked: Plasma's GTK helper
    # replaces them with regular files. config/plasma/apply.sh copies them.
    ".config/fastfetch".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/fastfetch;
    # Catppuccin Mocha mauve for Zen (stable profile).
    ".config/zen/exgyz0bm.Default Profile/chrome/userChrome.css".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/zen/userChrome.css;
    ".config/zen/exgyz0bm.Default Profile/chrome/userContent.css".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/zen/userContent.css;
    ".config/zen/exgyz0bm.Default Profile/chrome/zen-logo-mocha.svg".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/zen/zen-logo-mocha.svg;
    ".local/share/kwin/scripts/zen-no-topbar".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/plasma/kwin-scripts/zen-no-topbar;
    ".config/panel-colorizer/presets/tight-glass".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/plasma/panel-colorizer/tight-glass;
    ".local/share/color-schemes/CatppuccinMochaMauve.colors".source =
      config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/plasma/color-schemes/CatppuccinMochaMauve.colors;

    ".gitmux.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/gitmux.conf;
    };
  };
}
