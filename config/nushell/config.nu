def db [--impure] {
  if $"(^uname)" == "Darwin" {
      darwin-rebuild switch --flake "/Users/bahnasawy/dotfiles/nix#mac"
  } else {
        if $impure {
            sudo nixos-rebuild switch --flake $"/home/bahnasawy/dotfiles/nix#(hostname)" --impure
        } else {
            sudo nixos-rebuild switch --flake $"/home/bahnasawy/dotfiles/nix#(hostname)"
        }
  }
}

def nu [] {
  if $"(^uname)" == "Darwin" {
      nix flake update --flake /Users/bahnasawy/dotfiles/nix
  } else {
      sudo nix flake update --flake "/home/bahnasawy/dotfiles/nix"
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
    | get -i 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        # use zoxide completions for zoxide commands
        __zoxide_z | __zoxide_zi => $zoxide_completer
        _ => $carapace_completer
    } | do $in $spans
}

$env.config = {
  show_banner: false,
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
prepend /home/bahnasawy/.apps |
append /usr/bin/env
)