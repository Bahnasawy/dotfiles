{ config, ... }:
{
  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/nvim";
      recursive = true;
    };
    ".config/nushell" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/nushell";
      recursive = true;
    };
    ".config/ghostty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/ghostty";
      recursive = true;
    };
    ".config/gh" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/gh";
      recursive = true;
    };
    ".config/neovide" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/neovide";
      recursive = true;
    };
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/kitty";
      recursive = true;
    };
    ".config/raycast" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/raycast";
      recursive = true;
    };
    ".config/bat" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/bat";
      recursive = true;
    };
    ".config/yazi" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/yazi";
      recursive = true;
    };
    ".zshrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/zshrc";
    };
    ".zpreztorc" = {
      source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/zpreztorc";
    };
  };
}
