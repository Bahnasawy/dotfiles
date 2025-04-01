def  db --wrapped [...rest] {
  if $"(^uname)" == "Darwin" {
      darwin-rebuild switch --flake "/Users/bahnasawy/dotfiles/nix#mac" ...$rest 
  } else {
    sudo nixos-rebuild switch --flake $"/home/bahnasawy/dotfiles/nix#(hostname)" ...$rest
  }
}

def collect-garbage [] {
  sudo nix-collect-garbage -d
}

def fu [] {
  if $"(^uname)" == "Darwin" {
      nix flake update --flake /Users/bahnasawy/dotfiles/nix
  } else {
      sudo nix flake update --flake "/home/bahnasawy/dotfiles/nix"
  }
}

def dev [] {
    if $"(ls | str contains 'bun' name | where name == true | get 'name' | get 0)" == 'true' {
        bun run dev
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
        z | zi => $zoxide_completer
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
prepend /opt/homebrew/bin |
prepend /Users/bahnasawy/.local/bin |
prepend /home/bahnasawy/.apps |
prepend /etc/profiles/per-user/bahnasawy/bin |
append /usr/bin/env |
append /run/current-system/sw/bin |
append /Users/bahnasawy/.bun/bin |
append /home/bahnasawy/.bun/bin |
append /home/bahnasawy/.local/bin
)
if $"(^uname)" == "Darwin" {
    $env.ANDROID_HOME = "/Users/bahnasawy/.android/sdk"
    $env.ANDROID_SDK_ROOT = "/Users/bahnasawy/.android/sdk"
} else {
    $env.ANDROID_HOME = "/home/bahnasawy/Android/Sdk"
}
$env.config.shell_integration.osc133 = false

alias man = batman
