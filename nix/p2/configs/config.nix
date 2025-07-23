{config, ...}: {
  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/brandon/dotfiles/config/nvim;
    recursive = true;
  };
  home.file.".zoxide.nu" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/brandon/dotfiles/zoxide.nu;
  };
  home.file.".config/ghostty" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/brandon/dotfiles/config/ghostty";
    recursive = true;
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
      };
    };

    zoxide.enable = true;
    zoxide.enableNushellIntegration = true;
  };
}
