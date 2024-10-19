{config, ...}: {
  home.file.".config/kitty" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/.config/kitty;
    recursive = true;
  };

  home.file.".config/neovide" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/.config/neovide;
    recursive = true;
  };

  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/.config/nvim;
    recursive = true;
  };

  home.file.".zshrc" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/.zshrc;
    recursive = true;
  };

  home.file.".zpreztorc" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/.zpreztorc;
    recursive = true;
  };
}
