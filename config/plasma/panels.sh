#!/usr/bin/env bash
# Rebuilds the three panels: injects the tight-glass Panel Colorizer settings
# into panels.js and runs it in the Plasma shell.
set -eu
here=$(cd "$(dirname "$(readlink -f "$0")")" && pwd)
glass=$(python3 -c 'import json,sys; print(json.dumps(json.load(open(sys.argv[1]))["globalSettings"]))' \
  "$here/panel-colorizer/tight-glass/settings.json")
script=$(python3 -c 'import sys; print(open(sys.argv[1]).read().replace("__TIGHT_GLASS__", sys.argv[2]))' \
  "$here/panels.js" "$glass")
qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "$script"
