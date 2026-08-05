export ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"

source "$ZDOTDIR/options.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/env.zsh"
source "$ZDOTDIR/completions.zsh"

# ${UserConfigDir}/zsh/.zshrc
autoload -U compinit && compinit
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

eval "$(starship init zsh)"

# Load autosuggestions before highlighting so ghost text is styled correctly.
if [[ -r "$HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif [[ -r "/etc/profiles/per-user/$USER/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "/etc/profiles/per-user/$USER/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Keep this last so it can wrap all ZLE widgets installed above.
if [[ -r "$HOME/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$HOME/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif [[ -r "/etc/profiles/per-user/$USER/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "/etc/profiles/per-user/$USER/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi
