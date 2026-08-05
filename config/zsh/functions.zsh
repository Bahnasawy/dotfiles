db() {
  if [[ "$(uname)" == "Darwin" ]]; then
    nh darwin switch "$HOME/dotfiles/nix" -H mac "$@"
  else
    nh os switch "$HOME/dotfiles/nix" -H "$(hostname)" "$@"
  fi
}

collect-garbage() {
  nh clean all
}

fu() {
  if [[ "$(uname)" == "Darwin" ]]; then
    nix flake update --flake "$HOME/dotfiles/nix"
  else
    sudo nix flake update --flake "$HOME/dotfiles/nix"
  fi
}

dev() {
  if command ls | command grep -q bun; then
    bun run dev "$@"
  fi
}

clone-index-repo() {
  gh repo clone "Index-Infotech/$1" -- -c core.sshCommand="ssh -i ~/.ssh/index"
}
