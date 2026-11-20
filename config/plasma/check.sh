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

# Key names come from Darkly's kstyle/darkly.kcfg (no schema is installed).
# It has no scrollbar-width setting.
check_widgets() {
  key kdeglobals KDE widgetStyle Darkly
  key darklyrc Common CornerRadius 3
  key darklyrc Common FancyMargins false
  key darklyrc Common ButtonHeight 1
  key darklyrc Common MenuItemHeight 2
  key darklyrc Style MenuOpacity 90
  key darklyrc Style SidePanelDrawFrame false
  key darklyrc Style DockWidgetDrawFrame false
  key darklyrc Style TitleWidgetDrawFrame false
  key darklyrc Style ToolBarDrawSeparator false
  key darklyrc Style ToolBarDrawItemSeparator false
}

# Rounded-corners key names come from KDE-Rounded-Corners src/kcm/options.kcfg.
check_windows() {
  local r
  key kwinrc Windows BorderlessMaximizedWindows true
  key kwinrc Effect-overview BorderActivate 9
  key kwinrc Plugins kwin4_effect_shapecornersEnabled true
  key kwinrc Round-Corners Size 3
  key kwinrc Round-Corners InactiveCornerRadius 3
  key kwinrc Round-Corners OutlineThickness 1
  key kwinrc Round-Corners OutlineColor 203,166,247
  key kwinrc Round-Corners InactiveOutlineColor 69,71,90
  key kwinrulesrc open-maximized maximizehoriz true
  key kwinrulesrc open-maximized maximizehorizrule 3
  key kwinrulesrc open-maximized maximizevert true
  key kwinrulesrc open-maximized maximizevertrule 3
  key kwinrulesrc open-maximized types 1
  # open-maximized must be the last rule so the small-window rules win.
  case "$(kreadconfig6 --file kwinrulesrc --group General --key Order)" in
    *,open-maximized) ;;
    *) fail "open-maximized is not last in kwinrulesrc Order" ;;
  esac
  # Windows that must stay small keep an explicit not-maximized rule.
  for r in 854ac35e-bd6f-46f6-8ce5-696177d70e8c 7bcab82b-d549-4005-be33-8ec67ed4d42f \
    b3f61c94-3e34-45ef-8fef-f96d8f1037a2; do
    key kwinrulesrc "$r" maximizehoriz false
    key kwinrulesrc "$r" maximizehorizrule 3
    key kwinrulesrc "$r" maximizevert false
    key kwinrulesrc "$r" maximizevertrule 3
  done
  # Behavior: a fresh normal window opens covering the whole 3440x1440 screen.
  local win geo i
  kwrite >/dev/null 2>&1 &
  for i in 1 2 3 4 5 6 7 8 9 10; do
    sleep 0.5
    win=$(kdotool search --class kwrite 2>/dev/null | head -1)
    [ -n "$win" ] && break
  done
  if [ -z "$win" ]; then
    fail "kwrite window did not appear"
  else
    sleep 1
    geo=$(kdotool getwindowgeometry "$win" | tr -d ' \n')
    case "$geo" in
      *Position:0,0*Geometry:3440x1440*) ;;
      *) fail "kwrite opened at '$geo', want position 0,0 size 3440x1440" ;;
    esac
    kdotool windowclose "$win"
  fi
}

check_panels() {
  local actual want line
  actual=$(qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript \
    'var o=[]; panels().forEach(function(p){ o.push(p.location+"|"+p.height+"|"+p.hiding+"|"+p.widgets().map(function(w){return w.type}).join(",")); }); print(o.sort().join("\n"));')
  want="left|46|autohide|org.kde.plasma.kickoff,org.kde.plasma.icontasks,org.kde.plasma.panelspacer,org.kde.plasma.pager,luisbocanegra.panel.colorizer
right|46|autohide|org.kde.plasma.digitalclock,org.kde.plasma.panelspacer,org.kde.plasma.systemtray,org.kde.plasma.lock_logout,luisbocanegra.panel.colorizer
top|30|autohide|com.github.antroids.application-title-bar,org.kde.plasma.appmenu,org.kde.plasma.panelspacer,com.github.antroids.application-title-bar,luisbocanegra.panel.colorizer"
  if [ "$actual" != "$want" ]; then
    fail "panel layout differs:"
    diff <(echo "$want") <(echo "$actual") | sed 's/^/    /'
  fi
  is_link "$CFG/panel-colorizer/presets/tight-glass"
}

ALL_SECTIONS=(links look widgets windows panels)

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
