alias man='batman'
alias cd='z'
alias vi='nvim'

if [[ -n "$NIX_LDFLAGS" ]]; then
  alias ld='ld -L $NIX_LDFLAGS'
fi
