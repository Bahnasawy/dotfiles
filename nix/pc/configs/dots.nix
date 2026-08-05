{ config, ... }:
{
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

    ".config/zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/zsh;
      recursive = true;
    };

    ".zshenv" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/.zshenv;
    };

    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/nvim;
      recursive = true;
    };

    ".config/tmux" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/tmux;
      recursive = true;
    };
  };
}
