#!/usr/bin/env bash
# Test suite for the Plasma rice. Usage: check.sh [section ...]
# No argument runs every section. Exits 0 only if every assertion passes.
set -u

REPO_CONFIG=/home/bahnasawy/dotfiles/config/
CFG="$HOME/.config"
PROFILE_DIRS=(/run/current-system/sw "$HOME/.nix-profile" "/etc/profiles/per-user/$USER")

fails=0
section=""

fail() {
  echo "FAIL $section: $*"
  fails=$((fails + 1))
}

# is_link <path>: a symlink that resolves into the dotfiles config folder.
is_link() {
  local target
  if [ ! -L "$1" ]; then
    fail "$1 is not a symlink"
    return
  fi
  target=$(readlink -f "$1")
  case "$target" in
    "$REPO_CONFIG"*) ;;
    *) fail "$1 resolves to $target, outside $REPO_CONFIG" ;;
  esac
}

# key <file> <group[/subgroup...]> <key> <expected>
key() {
  local file=$1 groups=$2 name=$3 expected=$4 actual args=() g
  local IFS=/
  for g in $groups; do args+=(--group "$g"); done
  unset IFS
  actual=$(kreadconfig6 --file "$file" "${args[@]}" --key "$name" 2>/dev/null)
  [ "$actual" = "$expected" ] || fail "$file [$groups] $name is '$actual', want '$expected'"
}

# has <command>
has() {
  command -v "$1" >/dev/null 2>&1 || fail "command $1 not on PATH"
}

# in_profile <relative path>: exists under one of the Nix profile roots.
in_profile() {
  local d
  for d in "${PROFILE_DIRS[@]}"; do
    [ -e "$d/$1" ] && return 0
  done
  fail "$1 not found in any Nix profile"
}

check_links() {
  local f
  for f in kdeglobals kwinrc kwinrulesrc plasmarc plasmashellrc \
    plasma-org.kde.plasma.desktop-appletsrc kcminputrc kxkbrc powerdevilrc \
    kscreenlockerrc darklyrc; do
    is_link "$CFG/$f"
  done
  is_link "$HOME/.local/share/color-schemes/CatppuccinMochaMauve.colors"
  in_profile lib/qt-6/plugins/styles/darkly6.so
  in_profile share/plasma/plasmoids/luisbocanegra.panel.colorizer
  in_profile share/plasma/plasmoids/com.github.antroids.application-title-bar
  in_profile lib/qt-6/plugins/kwin/effects/plugins/kwin4_effect_shapecorners.so
  in_profile share/icons/Papirus-Dark
  in_profile share/icons/catppuccin-mocha-dark-cursors
  fc-list | grep -q "Inter" || fail "Inter font not installed"
}

check_look() {
  key kdeglobals General ColorScheme CatppuccinMochaMauve
  # No AccentColor key: Plasma darkens an explicit accent (mauve became 151,125,186).
  # The scheme itself carries mauve, so the accent must stay unset.
  key kdeglobals General AccentColor ""
  key kdeglobals "Colors:View" BackgroundNormal 30,30,46
  key kdeglobals "Colors:Window" BackgroundNormal 24,24,37
  key kdeglobals "Colors:Selection" BackgroundNormal 203,166,247
  key kdeglobals General font "Inter,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
  key kdeglobals General smallestReadableFont "Inter,8,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
  key kdeglobals General fixed "JetBrainsMono Nerd Font,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1"
  key kdeglobals WM activeFont "Inter,10,-1,5,500,0,0,0,0,0,0,0,0,0,0,1"
  key kdeglobals Icons Theme Papirus-Dark
  key kcminputrc Mouse cursorTheme catppuccin-mocha-dark-cursors
  key kcminputrc Mouse cursorSize 24
}

ALL_SECTIONS=(links look)

run() {
  section=$1
  local before=$fails
  "check_$1"
  [ "$fails" -eq "$before" ] && echo "ok $1"
}

if [ $# -eq 0 ]; then set -- "${ALL_SECTIONS[@]}"; fi
for s in "$@"; do
  if declare -F "check_$s" >/dev/null; then
    run "$s"
  else
    echo "FAIL: unknown section $s"
    fails=$((fails + 1))
  fi
done
[ "$fails" -eq 0 ]
