# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export EDITOR=code

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

alias rc="source $HOME/dotfiles/.zshrc"

export TOOLCHAINS=swift

alias zshrc="nvim $HOME/dotfiles/.zshrc"

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

if [[ `uname` == "Darwin" ]]; then
    export ANDROID_NDK_HOME=$HOME/Library/Android/sdk/ndk/27.0.11902837
    export ANDROID_HOME=$HOME/Library/Android/sdk
    alias nu='sudo nix flake update /Users/bahnasawy/dotfiles/nix/nix-darwin'
    alias db='darwin-rebuild switch --flake "/Users/bahnasawy/dotfiles/nix/nix-darwin#mac"'
else
    export ANDROID_NDK_HOME=$HOME/Android/Sdk/ndk/28.0.12433566
    export ANDROID_HOME=$HOME/Android/Sdk
    alias nu='sudo nix flake update --flake "/home/bahnasawy/dotfiles/nix" |& nom'
    alias db='sudo nixos-rebuild switch --flake "/home/bahnasawy/dotfiles/nix#$(hostname)" |& nom'
fi
