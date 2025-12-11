{ config, ... }:
{
  home.file = {
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/kitty;
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

    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/nvim;
      recursive = true;
    };

    ".zoxide.nu" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/zoxide.nu;
    };
    ".config/tmux" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/tmux;
      recursive = true;
    };
  };
}
