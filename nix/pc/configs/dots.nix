{config, ...}: {
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

    ".config/herdr" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/herdr;
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

    ".config/git" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/git;
      recursive = true;
    };

    ".config/yazi" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/yazi;
      recursive = true;
    };

    ".gitmux.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/gitmux.conf;
    };
  };
}
