{ config, ... }:
{
  home = {
    file = {
      ".config/tmux" = {
        source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/tmux";
        recursive = true;
      };
      ".config/opencode" = {
        source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/opencode";
        recursive = true;
      };
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
      ".config/tuicr" = {
        source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/tuicr";
        recursive = true;
      };
      ".gitmux.conf" = {
        source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/gitmux.conf";
      };
      ".cargo/config.toml" = {
        text = ''
          [target.aarch64-apple-darwin]
          rustflags = ["-L/opt/homebrew/Cellar/libiconv/1.18/lib"]
        '';
      };
      ".config/sesh" = {
        source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/sesh";
        recursive = true;
      };
      ".config/zsh" = {
        source = config.lib.file.mkOutOfStoreSymlink "/Users/bahnasawy/dotfiles/config/zsh";
        recursive = true;
      };
    };
  };
}
