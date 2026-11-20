#!/usr/bin/env bash
# Installs the rice files that cannot be symlinks.
#
# gtk.css: Plasma's GTK helper (kde-gtk-config) replaces ~/.config/gtk-*/gtk.css
# with a regular file to keep its "@import 'colors.css'" line, so a link does
# not survive and then blocks home-manager activation. Found 2026-11-20.
set -eu
here=$(cd "$(dirname "$(readlink -f "$0")")" && pwd)

apply_gtk() {
  local d
  for d in gtk-3.0 gtk-4.0; do
    mkdir -p "$HOME/.config/$d"
    cp -f "$here/gtk/gtk.css" "$HOME/.config/$d/gtk.css"
  done
}

apply_gtk
