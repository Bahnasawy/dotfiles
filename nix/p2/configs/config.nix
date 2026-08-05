{config, ...}: {
  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/brandon/dotfiles/config/nvim;
    recursive = true;
  };
  home.file.".config/ghostty" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/brandon/dotfiles/config/ghostty";
    recursive = true;
  };
  programs = {
    carapace.enable = true;

    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };

    zoxide.enable = true;
  };
}
