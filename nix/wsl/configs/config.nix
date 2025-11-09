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
      ".zoxide.nu" = {
        source = config.lib.file.mkOutOfStoreSymlink /home/bahnasawy/dotfiles/zoxide.nu;
      };
      ".config/ghostty" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/bahnasawy/dotfiles/config/ghostty";
        recursive = true;
      };
    };
  };
  programs = {
    nushell = {
      enable = true;
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
        nano = "nvim";
      };

      configFile.source = config.lib.file.mkOutOfStoreSymlink ../../../config/nushell/config.nu;
    };

    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship = {
      enable = true;
      enableNushellIntegration = true;
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
    zoxide.enableNushellIntegration = true;
  };
}
