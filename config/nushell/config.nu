def  db --wrapped [...rest] {
  if $"(^uname)" == "Darwin" {
      sudo darwin-rebuild switch --flake $"($env.HOME)/dotfiles/nix#mac" ...$rest 
  } else {
    sudo nixos-rebuild switch --flake $"($env.HOME)/dotfiles/nix#(hostname)" ...$rest
  }
}

def collect-garbage [] {
  sudo nix-collect-garbage -d
}

def fu [] {
  if $"(^uname)" == "Darwin" {
      nix flake update --flake $"($env.HOME)/dotfiles/nix"
  } else {
      sudo nix flake update --flake $"($env.HOME)/dotfiles/nix"
  }
}

def dev --wrapped  [...rest] {
    if $"(ls | str contains 'bun' name | where name == true | get 'name' | get 0)" == 'true' {
        bun run dev ...$rest
    }
}

$env.EDITOR = 'nvim'

let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

# This completer will use carapace by default
let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get --optional 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        # use zoxide completions for zoxide commands
        z | zi | cd => $zoxide_completer
        __zoxide_z | __zoxide_zi => $zoxide_completer
        _ => $carapace_completer
    } | do $in $spans
}

$env.config = {
  show_banner: false,
  edit_mode: vi    # emacs or vi
  completions: {
  case_sensitive: false # case-sensitive completions
  quick: true    # set to false to prevent auto-selecting completions
  partial: true    # set to false to prevent partial filling of the prompt
  algorithm: "fuzzy"    # prefix or fuzzy
  external: {
  # set to false to prevent nushell looking into $env.PATH to find more suggestions
      enable: true
  # set to lower can improve completion performance at the cost of omitting some options
      max_results: 100
      completer: $external_completer # check 'carapace_completer'
    }
  }
}
$env.PATH = ($env.PATH |
split row (char esep) |
prepend ~/.local/bin |
prepend ~/.apps |
prepend /etc/profiles/per-user/bahnasawy/bin |
append /usr/bin/env |
append /run/current-system/sw/bin |
append ~/.bun/bin |
append ~/.bun/bin |
append ~/.local/bin |
append ~/go/bin |
append /opt/homebrew/bin |
append ~/.cargo/bin
)
if $"(^uname)" == "Darwin" {
    $env.ANDROID_HOME = "/Users/bahnasawy/.android/sdk"
    $env.ANDROID_SDK_ROOT = "/Users/bahnasawy/.android/sdk"
    # $env.NIX_LDFLAGS = "-L/nix/store/xppzbf3fssn7g35ixgzifkwj54x419n5-libcxx-19.1.7/lib -L/nix/store/zqc178w2vh4lkxmy3znl5s2xl7d401nr-compiler-rt-libc-19.1.7/lib -L/nix/store/fhza62gkyw0mp1h2zls6pl1832zjjf26-libiconv-109/lib -L/nix/store/xdp9yf1r58jzfw1rh68qdhp0d923l07w-libresolv-83/lib -L/nix/store/w2gmrz3ki4lqwb0gw95bjsrwlhknq8ks-libsbuf-14.1.0/lib -L/nix/store/jmq7mr51dql3w8y26kzf4j1s62k6mfww-libutil-72/lib -L/nix/store/xppzbf3fssn7g35ixgzifkwj54x419n5-libcxx-19.1.7/lib -L/nix/store/zqc178w2vh4lkxmy3znl5s2xl7d401nr-compiler-rt-libc-19.1.7/lib -L/nix/store/fhza62gkyw0mp1h2zls6pl1832zjjf26-libiconv-109/lib -L/nix/store/xdp9yf1r58jzfw1rh68qdhp0d923l07w-libresolv-83/lib -L/nix/store/w2gmrz3ki4lqwb0gw95bjsrwlhknq8ks-libsbuf-14.1.0/lib -L/nix/store/jmq7mr51dql3w8y26kzf4j1s62k6mfww-libutil-72/lib"
} else {
    $env.ANDROID_HOME = "~/.android/"
}
$env.config.shell_integration.osc133 = false
$env.CROSS_CONTAINER_ENGINE = 'podman'
$env.CROSS_CONTAINER_OPTS = '--platform=linux/amd64'



alias man = batman
alias z = cd

if $env.TERM != "tmux-256color" { 
  tmux
}
