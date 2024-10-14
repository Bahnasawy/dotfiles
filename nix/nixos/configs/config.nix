{...}: {
  home.file.".config" = {
    source = ../../../.config;
    recursive = true; # link recursively
  };

  home.file.".zshrc" = {
    source = ../../../.zshrc;
  };

  home.file.".zpreztorc" = {
    source = ../../../.zpreztorc;
  };
}
