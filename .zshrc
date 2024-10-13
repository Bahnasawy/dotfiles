# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export EDITOR=code
export ANDROID_NDK_HOME=$HOME/Library/Android/sdk/ndk/27.0.11902837
export ANDROID_HOME=$HOME/Library/Android/sdk

if [[ -s "${$HOME}/dotfiles/nix/configuration.nix" ]]; then
   export NIX_PATH=$HOME/dotfiles/nix/configuration.nix
fi


alias ls="lsd -1"

function dev() {
  if [[ -f bun.lockb ]]; then
    bun dev
  elif [[ -f package-lock.json ]]; then
    npm run dev
  elif [[ -f pnpm-lock.yaml ]]; then
    pnpm dev
  else 
    yarn dev
  fi
}

alias download="wget -P $HOME/Downloads"

alias rc="source $HOME/.zshrc"

export TOOLCHAINS=swift

alias zshrc="nvim $HOME/.zshrc"

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

fun() {
  cd "$HOME/fun/$1"
}

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

eval "$(zoxide init --cmd cd zsh)"

export BW_SESSION="RcXrgwVRaDqbqcMkn5wevFQpBto6BJsrU22duHzKFUJfjZ4BPV3hnk7D2s43NqSEvI08XiDlTR7Z0xhmoHCQTg=="

eval "$(fzf --zsh)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export CROSS_CONTAINER_ENGINE=podman

elif [[ `uname` == "Darwin" ]]; then
    alias db='darwin-rebuild switch --flake "/Users/bahnasawy/dotfiles/nix-darwin#mac"'
else
    NIX_PATH="nixos-config=~/dotfiles/nix/configuration.nix"
    alias db='sudo nixos-rebuild switch -I $NIX_PATH'
fi
