{ config, ... }:
{
  home = {
    file = {
      ".config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/nvim;
        recursive = true;
      };
      ".config/tmux" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/config/tmux;
        recursive = true;
      };
      ".config/ghostty" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/bahnasawy/dotfiles/config/ghostty";
        recursive = true;
      };
    };
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
        custom = {
          jj = {
            command = "prompt";
            format = "$output";
            ignore_timeout = true;
            shell = [
              "starship-jj"
              "--ignore-working-copy"
              "starship"
            ];
            use_stdin = false;
            when = true;
          };
        };
      };
    };

    zoxide.enable = true;
  };
}
