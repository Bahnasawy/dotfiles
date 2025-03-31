{ config, ... }:
{
  home.file.".config/kitty" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/kitty;
    recursive = true;
  };

  home.file.".config/neovide" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/neovide;
    recursive = true;
  };

  home.file.".config/ghostty" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/ghostty;
    recursive = true;
  };

  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/nvim;
    recursive = true;
  };

  home.file.".zoxide.nu" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/zoxide.nu;
  };
}
