autoload -Uz compinit
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

if command -v carapace >/dev/null 2>&1; then
  source <(carapace _carapace zsh)
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' max-results 100
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
