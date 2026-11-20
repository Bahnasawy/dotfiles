# Plasma Rice Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Turn the `pc` host's stock Breeze Dark desktop into a Catppuccin Mocha (mauve) desktop where apps open maximized and borderless and three translucent panels reveal on edge hover.

**Architecture:** Every Plasma settings file lives in `~/dotfiles/config/plasma/` and is linked into place per file through `nix/pc/configs/dots.nix`. Nix only installs packages, creates the links and sets the SDDM theme. A shell script, `config/plasma/check.sh`, is the test suite: each task adds its assertions first, sees them fail, then makes them pass.

**Tech Stack:** NixOS 26.11 flake with home-manager, Plasma 6.8.2 on Wayland, KWin rules, `kwriteconfig6`/`kreadconfig6`, Plasma shell scripting over `qdbus6`, Darkly, Panel Colorizer, KDE Rounded Corners, Application Title Bar.

**Spec:** `docs/superpowers/specs/2026-11-19-plasma-rice-design.md`

## Global Constraints

- Work on branch `plasma-rice` in `/home/bahnasawy/dotfiles`. Never stage `config/tuios/config.toml` or `nix/flake.lock`; they hold the user's unrelated uncommitted changes.
- Only host `pc` changes. Do not touch `laptop`, `usb`, `mac`, `wsl`, `p2`.
- Rebuilds need sudo and are run by the user (`nh os switch`). Stop and ask; never run them.
- New files must be `git add`ed before a rebuild: a flake only sees tracked files.
- Symlink sources use absolute `/home/bahnasawy/dotfiles/...` paths with `config.lib.file.mkOutOfStoreSymlink`, matching existing `dots.nix` entries.
- Palette: base `#1e1e2e`, mantle `#181825`, crust `#11111b`, surface0 `#313244`, surface1 `#45475a`, text `#cdd6f4`, subtext0 `#a6adc8`, mauve `#cba6f7`, red `#f38ba8`, yellow `#f9e2af`, green `#a6e3a1`.
- Shape: 3px corner radius, 3px gap from screen edge, panel opacity ~78% with blur.
- Fonts: Inter 10pt (general), Inter 8pt (small), Inter Medium 10pt (window titles), JetBrainsMono Nerd Font 10pt (fixed).
- Panels: rails ~46px wide, top bar ~30px tall, all auto-hide.
- Do not change `stateVersion`.
- Each task ends with a user look at the real screen. Tune values with them before committing.
- One commit per task, ending with `Co-Authored-By: Claude <noreply@anthropic.com>`.

## Review Focus

1. **Plasma rewrites a linked settings file by rename.** Expected: the link survives, or the file is moved to `apply.sh`. Pinned in Task 1, Step 8.
2. **Windows that are "normal" type but must stay small** (Zen picture-in-picture, Steam's login window, KCalc). Expected: PiP and Steam helper windows keep their size. Pinned in Task 4, Step 6.
3. **A notification or an app demanding attention while all panels are hidden.** Expected: the notification popup still shows; the left rail reveals for an attention request. Pinned in Task 5, Step 7.
4. **Arabic text with Inter as the interface font.** Expected: Arabic renders in Noto with no missing-glyph boxes. Pinned in Task 2, Step 7.
5. **A second display is connected** (`system.nix` has kernel params for `DP-1` and `HDMI-A-1`). Expected: the three panels stay on the primary display and nothing errors. Pinned in Task 5, Step 8.

---

## File Structure

| Path | Responsibility |
|---|---|
| `config/plasma/check.sh` | Test suite. `check.sh <section>` runs one section, no argument runs all. Exit 0 only if every assertion passes. |
| `config/plasma/{kdeglobals,kwinrc,kwinrulesrc,plasmarc,plasmashellrc,plasma-org.kde.plasma.desktop-appletsrc,kcminputrc,kxkbrc,powerdevilrc,kscreenlockerrc,darklyrc}` | Live Plasma settings files, linked into `~/.config/`. |
| `config/plasma/color-schemes/CatppuccinMochaMauve.colors` | The single color source. Linked into `~/.local/share/color-schemes/`. |
| `config/plasma/panels.js` | Plasma shell script that builds the three panels from scratch. Source of truth for layout. |
| `config/plasma/panel-colorizer/tight-glass/` | Panel Colorizer preset. Linked into `~/.config/panel-colorizer/presets/tight-glass`. |
| `config/plasma/gtk/gtk.css` | 3px-corner override, linked to `~/.config/gtk-3.0/gtk.css` and `~/.config/gtk-4.0/gtk.css`. |
| `config/plasma/wallpapers/` | Chosen wallpaper. |
| `config/plasma/apply.sh` | Created only if Task 1 finds a file whose link does not survive. |
| `config/fastfetch/config.jsonc`, `config/zen/` | Terminal and browser extras. |
| `nix/pc/configs/dots.nix` | New link entries. |
| `nix/pc/configs/packages.nix` | New packages; `programs.plasma` block removed; starship palette. |
| `nix/pc/configs/system.nix` | Inter font; SDDM theme. |

`check.sh` helper contract, used by every task:

- `is_link <path>`: passes if `<path>` is a symlink whose `readlink -f` target starts with `/home/bahnasawy/dotfiles/config/`.
- `key <file> <group> <key> <expected>`: passes if `kreadconfig6 --file <file> --group <group> --key <key>` prints `<expected>`. Nested groups are passed as repeated `--group` values separated by `/` in the argument.
- `has <command>`: passes if the command is on `PATH`.
- Each failure prints `FAIL <section>: <what>`; each section prints `ok <section>` when clean.

Screenshots for self-checks: `spectacle -b -n -f -o <scratchpad>/<task>.png`, then read the image.

---

### Task 1: Snapshot, packages, links and the survival test

**Files:**
- Create: `config/plasma/check.sh`, and copies of the live settings files listed above
- Modify: `nix/pc/configs/dots.nix`, `nix/pc/configs/packages.nix`, `nix/pc/configs/system.nix`

**Interfaces:**
- Produces: `check.sh` with helpers `is_link`, `key`, `has`; section name `links`. Every later task appends a section.
- Produces: linked settings files at their `~/.config` paths, editable in place.

- [ ] **Step 1: Write `check.sh` with the `links` section**

Assertions: `is_link` for each of `~/.config/{kdeglobals,kwinrc,kwinrulesrc,plasmarc,plasmashellrc,plasma-org.kde.plasma.desktop-appletsrc,kcminputrc,kxkbrc,powerdevilrc,kscreenlockerrc,darklyrc}`; `has` for `darkly-settings6` or, if Darkly ships no such binary, a check that `Darkly` appears in `ls /run/current-system/sw/lib/qt-6/plugins/styles`; `fc-list | grep -q "Inter"`; the directories `Papirus-Dark` and a `catppuccin-mocha-dark-cursors` cursor theme exist under `/run/current-system/sw/share/icons` or `~/.nix-profile/share/icons`.

- [ ] **Step 2: Run it and confirm it fails**

Run: `bash config/plasma/check.sh links`
Expected: `FAIL links:` lines for every file (none are links yet) and for the missing packages.

- [ ] **Step 3: Snapshot the live files**

Copy each file from `~/.config/` into `config/plasma/`. Create empty files for any that do not exist yet (`kwinrulesrc`, `darklyrc`, `kscreenlockerrc` may not). Also keep a dated backup outside the repo at `~/.config/plasma-rice-backup-2026-11-19/`.

- [ ] **Step 4: Move keyboard and power settings out of `programs.plasma`**

The block in `packages.nix` sets keyboard layouts `us` and `eg` and AC power settings (no auto-suspend, no display dimming, and whatever follows in that block). Confirm those values are already present in the snapshotted `kxkbrc` and `powerdevilrc`; write any that are missing with `kwriteconfig6 --file <snapshot path>`. Then delete the whole `programs.plasma` block.

- [ ] **Step 5: Add packages**

In `packages.nix` `home.packages`: `darkly`, `plasma-panel-colorizer`, `kde-rounded-corners`, `application-title-bar`, `papirus-icon-theme`, `(catppuccin-papirus-folders.override { flavor = "mocha"; accent = "mauve"; })`, `catppuccin-cursors.mochaDark`. Leave `catppuccin-kde` in place. In `system.nix` `fonts.packages`: add `pkgs.inter`.

- [ ] **Step 6: Add link entries to `dots.nix`**

One `home.file` entry per settings file, non-recursive, in the existing style. Also `".local/share/color-schemes/CatppuccinMochaMauve.colors"` (create an empty placeholder file now so the link resolves).

- [ ] **Step 7: Validate, then hand the rebuild to the user**

Run: `git add config/plasma nix/pc/configs && cd nix && nix flake check --no-build`
Expected: no evaluation errors. If a package attribute is missing in the newer `flake.lock` revision, find its current name with `nix search` and fix it before asking.
Then ask the user to run `nh os switch` and log out and back in.

- [ ] **Step 8: Survival test (Review Focus 1)**

Run `bash config/plasma/check.sh links`; expected `ok links`. Then for each linked file, cause Plasma to rewrite it and re-run the check:
- `kdeglobals`: `plasma-apply-colorscheme BreezeDark`
- `kwinrc`: toggle any effect with `kwriteconfig6` then `qdbus6 org.kde.KWin /KWin reconfigure`, and move a tile boundary in the tiling editor
- applets file and `plasmashellrc`: ask the user to change the left panel's height by one step in edit mode and exit edit mode
- `kcminputrc`: `plasma-apply-cursortheme breeze_cursors`
- then ask the user to log out and in once more

Expected: `ok links` after each. For any file that fails, remove its `dots.nix` entry, create `config/plasma/apply.sh` with one function per failed file that writes its keys via `kwriteconfig6` from the copy in `config/plasma/`, change that file's `is_link` assertion to a `key` assertion on one representative key, and record the decision in a comment at the top of `apply.sh`.

- [ ] **Step 9: Commit**

```bash
git add config/plasma nix/pc/configs/dots.nix nix/pc/configs/packages.nix nix/pc/configs/system.nix docs/superpowers/plans
git commit -m "Link Plasma settings from config/plasma and add rice packages"
```

---

### Task 2: Colors, fonts, icons, cursor

**Files:**
- Create: `config/plasma/color-schemes/CatppuccinMochaMauve.colors`
- Modify: `config/plasma/kdeglobals`, `config/plasma/kcminputrc`, `config/plasma/check.sh`

**Interfaces:**
- Consumes: `check.sh` helpers from Task 1.
- Produces: color scheme named `CatppuccinMochaMauve`, which Tasks 3, 5 and 6 rely on being active.

- [ ] **Step 1: Add the `look` section to `check.sh`**

```
key kdeglobals General ColorScheme CatppuccinMochaMauve
key kdeglobals General AccentColor 203,166,247
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
```

- [ ] **Step 2: Run it and confirm it fails**

Run: `bash config/plasma/check.sh look` — expected `FAIL look:` on every line.

- [ ] **Step 3: Write `CatppuccinMochaMauve.colors`**

Start from the structure of `~/.local/share/color-schemes/CatppuccinMocha.colors` (same groups and keys). Map roles to the palette in Global Constraints: `Colors:View` background base, alternate mantle; `Colors:Window`, `Colors:Header`, `Colors:Complementary` background mantle; `Colors:Button` background surface0; `Colors:Tooltip` background crust; `Colors:Selection` background mauve with foreground crust; all `ForegroundNormal` text, `ForegroundInactive` subtext0, `ForegroundLink` and `DecorationFocus` mauve, `DecorationHover` mauve, `ForegroundNegative` red, `ForegroundNeutral` yellow, `ForegroundPositive` green. `[WM]` active and inactive background mantle, active foreground text, inactive foreground subtext0. `[General] Name=Catppuccin Mocha Mauve`, `ColorScheme=CatppuccinMochaMauve`.

- [ ] **Step 4: Apply colors, fonts, icons, cursor**

`plasma-apply-colorscheme CatppuccinMochaMauve`; `plasma-apply-cursortheme catppuccin-mocha-dark-cursors`; the font and icon keys from Step 1 with `kwriteconfig6`; also set `menuFont` and `toolBarFont` to the general font string. Apply icons with `/run/current-system/sw/libexec/plasma-changeicons Papirus-Dark`, falling back to the `kwriteconfig6` key if that helper is absent.

- [ ] **Step 5: Run the check**

Run: `bash config/plasma/check.sh look` — expected `ok look`. Run `bash config/plasma/check.sh links` — expected `ok links`.

- [ ] **Step 6: Screenshot self-check**

Open Dolphin and System Settings, take a screenshot, and confirm: base/mantle layering visible, mauve selection, Inter in menus, Papirus icons with mauve folders.

- [ ] **Step 7: Arabic fallback (Review Focus 4)**

Run: `fc-match "Inter:lang=ar" family` — expected a Noto Arabic family, not Inter. Then `kdialog --msgbox "مرحبا بالعالم — Hello"` and screenshot: Arabic shaped correctly, no boxes.

- [ ] **Step 8: User look, tune, commit**

```bash
git add config/plasma
git commit -m "Apply Catppuccin Mocha mauve colors, Inter, Papirus and cursor"
```

---

### Task 3: Darkly widget style

**Files:**
- Modify: `config/plasma/kdeglobals`, `config/plasma/darklyrc`, `config/plasma/check.sh`

**Interfaces:**
- Consumes: active `CatppuccinMochaMauve` scheme.
- Produces: `[KDE] widgetStyle=Darkly`.

- [ ] **Step 1: Find Darkly's setting names**

Read the installed schema: `find /run/current-system/sw ~/.nix-profile -name 'darkly*.kcfg'`. Record the exact key names for: corner radius, menu opacity, scrollbar width, sidebar/toolbar frame drawing, toolbar and menu-item spacing. If no kcfg is installed, open `darkly-settings6`, change each setting once and diff `darklyrc`.

- [ ] **Step 2: Add the `widgets` section to `check.sh`**

`key kdeglobals KDE widgetStyle Darkly`, plus one `key darklyrc ...` assertion per setting found in Step 1, with these values: corner radius `3`; menu opacity `90` (percent, or the schema's equivalent); frames around sidebars and toolbars off; the smallest spacing options the schema offers.

- [ ] **Step 3: Run it and confirm it fails**

Run: `bash config/plasma/check.sh widgets` — expected `FAIL widgets:` lines.

- [ ] **Step 4: Apply**

`kwriteconfig6 --file kdeglobals --group KDE --key widgetStyle Darkly`, write the `darklyrc` keys, then `qdbus6 org.kde.KWin /KWin reconfigure` and restart Dolphin.

- [ ] **Step 5: Run the check, screenshot, user look, commit**

Expected `ok widgets`. Screenshot Dolphin with a context menu open: 3px corners on buttons, inputs and the menu; menu slightly translucent; no frame lines around the sidebar.

```bash
git add config/plasma
git commit -m "Use Darkly with 3px corners and compact spacing"
```

---

### Task 4: Window behavior

**Files:**
- Modify: `config/plasma/kwinrc`, `config/plasma/kwinrulesrc`, `config/plasma/check.sh`

**Interfaces:**
- Produces: rule group id `open-maximized` in `kwinrulesrc`; later exclusions are added as further rule groups listed before it.

- [ ] **Step 1: Add the `windows` section to `check.sh`**

```
key kwinrc Windows BorderlessMaximizedWindows true
key kwinrc Effect-overview BorderActivate 9
key kwinrc Plugins kwin4_effect_shapecornersEnabled true
key kwinrulesrc open-maximized maximizehoriz true
key kwinrulesrc open-maximized maximizehorizrule 3
key kwinrulesrc open-maximized maximizevert true
key kwinrulesrc open-maximized maximizevertrule 3
key kwinrulesrc open-maximized types 1
```

Plus KDE Rounded Corners keys once Step 3 has their names. Also a behavioral assertion: launch `kwrite`, wait for its window, and require `kdotool getactivewindow getwindowgeometry` to report position `0,0` and size `3440x1440`; close it afterwards.

- [ ] **Step 2: Run it and confirm it fails**

Run: `bash config/plasma/check.sh windows` — expected `FAIL windows:` lines.

- [ ] **Step 3: Apply**

Write the `kwinrc` keys. Write `kwinrulesrc` with `[General] count=1`, `rules=open-maximized`, and group `[open-maximized]` holding `Description=Open maximized`, the four maximize keys and `types=1` (normal windows only; rule value `3` is Apply Initially). For KDE Rounded Corners, read its kcfg (`find /run/current-system/sw ~/.nix-profile -path '*shapecorners*' -name '*.kcfg'`) and set: active and inactive corner radius `3`, active outline color mauve `203,166,247`, outline thickness `1`, inactive outline color surface1 `69,71,90`. Reload with `qdbus6 org.kde.KWin /KWin reconfigure`.

- [ ] **Step 4: Run the check**

Expected `ok windows`. The previously saved panel layout is still Breeze at this point, so the geometry assertion may report the panel-reduced area; if so, mark that one assertion to be re-run in Task 5 rather than loosening it.

- [ ] **Step 5: Dialogs keep their size**

Open Dolphin's Configure dialog. Expected: natural size, 3px corners, title bar present, mauve outline when focused. Un-maximize Dolphin and snap it into the 25/50/25 tiling layout; expected: tiling still works.

- [ ] **Step 6: Small "normal" windows (Review Focus 2)**

Open a video in Zen and pop it into picture-in-picture; start Steam and watch its login/update window. Expected: neither is maximized. For any that is, add a rule group ahead of `open-maximized` in `rules=` that matches its window class (and title for PiP) with `maximizehorizrule=2`, `maximizevertrule=2` (Force) and both values `false`, and add a `key` assertion for it. KCalc and similar small apps are left maximized unless the user asks otherwise; ask them.

- [ ] **Step 7: User look, commit**

```bash
git add config/plasma
git commit -m "Open windows maximized and borderless with 3px corners"
```

---

### Task 5: The three panels

**Files:**
- Create: `config/plasma/panels.js`, `config/plasma/panel-colorizer/tight-glass/`
- Modify: `config/plasma/check.sh`, `nix/pc/configs/dots.nix` (preset link), and the applets file and `plasmashellrc` change as a result of running the script

**Interfaces:**
- Consumes: `open-maximized` rule and color scheme from earlier tasks.
- Produces: `panels.js`, runnable with `qdbus6 org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "$(cat config/plasma/panels.js)"`. Running it twice yields the same three panels.

- [ ] **Step 1: Add the `panels` section to `check.sh`**

Assertions, evaluated by running a small read-only shell script through `evaluateScript` that prints one line per panel as `location|height|hiding|comma-separated widget types`:

```
left|46|autohide|org.kde.plasma.kickoff,org.kde.plasma.icontasks,org.kde.plasma.panelspacer,org.kde.plasma.pager,luisbocanegra.panel.colorizer
right|46|autohide|org.kde.plasma.digitalclock,org.kde.plasma.panelspacer,org.kde.plasma.systemtray,org.kde.plasma.lock_logout,luisbocanegra.panel.colorizer
top|30|autohide|com.github.antroids.application-title-bar,org.kde.plasma.appmenu,org.kde.plasma.panelspacer,com.github.antroids.application-title-bar,luisbocanegra.panel.colorizer
```

Exactly three panels. Confirm the two third-party plugin ids against `ls /run/current-system/sw/share/plasma/plasmoids ~/.nix-profile/share/plasma/plasmoids` and correct the strings if the packages use different ids. Also `is_link ~/.config/panel-colorizer/presets/tight-glass`.

- [ ] **Step 2: Run it and confirm it fails**

Run: `bash config/plasma/check.sh panels` — expected `FAIL panels:` (two Breeze panels today).

- [ ] **Step 3: Write `panels.js`**

Remove every existing panel, then create the three from the table in the spec's Section 2. Left and right: `location` `left`/`right`, `height = 46`, `hiding = "autohide"`, full length. Top: `location = "top"`, `height = 30`, `hiding = "autohide"`, `alignment = "center"`, length fixed at screen width minus 2 × (46 + 3 + 3) so it sits between the rails. Widgets in the order asserted in Step 1. The first title-bar widget shows the app name only; the second shows minimize, maximize, close only. Icons-only task manager: mauve indicator comes from the color scheme. Clock: show date, vertical layout. Keep the user's existing pinned launchers by reading them from the snapshotted applets file before removal.

- [ ] **Step 4: Build the `tight-glass` preset**

Add one Panel Colorizer widget per panel, configure it in its settings UI to: background surface0 `#313244` at 78% opacity, blur on, radius 3, margin 3 on the screen-edge side, 1px border text color at ~18% opacity, widget spacing at the minimum, native panel background hidden. Save as preset `tight-glass`, move the saved preset folder into `config/plasma/panel-colorizer/tight-glass/`, add the `dots.nix` link entry, and make `panels.js` apply the preset to each panel's colorizer widget so a fresh run reproduces the look.

- [ ] **Step 5: Run the script and the checks**

Run the `evaluateScript` command, then `bash config/plasma/check.sh panels` (expected `ok panels`) and re-run `bash config/plasma/check.sh windows` (expected `ok windows`, including the 3440×1440 geometry assertion).

- [ ] **Step 6: Hover behavior and screenshots**

With Dolphin focused: use `ydotool mousemove` to touch the left, right and top edges in turn, screenshot each, and confirm the matching panel is visible, translucent, 3px-cornered, 3px off the edge, and that Dolphin's menus appear in the top bar. Move the pointer away and confirm all three hide. Press Meta and confirm the launcher opens. Tune the reveal delay with the user.

- [ ] **Step 7: Notifications and attention while hidden (Review Focus 3)**

Run `notify-send "rice test" "visible?"` — expected: the popup appears with panels hidden. Run `kdialog --msgbox test &` from a terminal on another virtual desktop to raise an attention request — expected: the left rail reveals. If it does not, tell the user and agree a fallback with them (for example a KWin-level attention indicator) before changing anything; do not change the rail away from `autohide`.

- [ ] **Step 8: Second display (Review Focus 5)**

If a second display is available, ask the user to plug it in: expected the three panels remain on the 3440×1440 display and `check.sh panels` still passes. If none is available, state that this check was not run.

- [ ] **Step 9: Persistence, user look, commit**

Ask the user to log out and in. Run `bash config/plasma/check.sh` (all sections) — expected every section `ok`.

```bash
git add config/plasma nix/pc/configs/dots.nix
git commit -m "Build the three auto-hiding translucent panels"
```

---

### Task 6: Extras

**Files:**
- Create: `config/plasma/gtk/gtk.css`, `config/fastfetch/config.jsonc`, `config/zen/`, `config/plasma/wallpapers/<chosen>`
- Modify: `config/ghostty/config`, `config/plasma/kscreenlockerrc`, `config/plasma/check.sh`, `nix/pc/configs/dots.nix`, `nix/pc/configs/packages.nix`, `nix/pc/configs/system.nix`

**Interfaces:**
- Consumes: everything above.

- [ ] **Step 1: Add the `extras` section to `check.sh`**

`is_link` for `~/.config/gtk-3.0/gtk.css`, `~/.config/gtk-4.0/gtk.css`, `~/.config/fastfetch`; `grep -q 'window-padding-x' ~/.config/ghostty/config`; `starship print-config | grep -q 'palette = "catppuccin_mocha"'`; `key kscreenlockerrc Greeter/Wallpaper/org.kde.image/General Image <path of chosen wallpaper>`; `grep -q 'catppuccin-mocha-mauve' /etc/sddm.conf.d/*` or the equivalent generated SDDM config path.

- [ ] **Step 2: Run it and confirm it fails**

Run: `bash config/plasma/check.sh extras` — expected `FAIL extras:` lines.

- [ ] **Step 3: GTK**

Set the GTK theme to Breeze through Plasma (`kwriteconfig6 --file kdeglobals` is not enough; use System Settings' GTK page key in `~/.config/gtk-3.0/settings.ini` and `gtk-4.0/settings.ini`, `gtk-theme-name=Breeze`). Write `gtk.css` with a 3px `border-radius` on buttons, entries, menus and popovers, importing the Plasma-generated `colors.css`. Add both link entries. Test with a GTK app that is installed; `transmission` is Qt, so use Firefox's file picker or `zenity --info` if present. Also test GTK menu export once and record the result in the commit message; do not add packages for it if it fails.

- [ ] **Step 4: Zen and Firefox**

Fetch the Catppuccin Zen theme's Mocha mauve `userChrome.css`, `userContent.css` and logo into `config/zen/` (its own new directory; read the files before linking them). Link them into the Zen profile's `chrome/` directory via `dots.nix`, finding the profile path under `~/.zen/`. Tell the user the one-click Firefox theme to install.

- [ ] **Step 5: Terminal**

Ghostty: add `window-padding-x = 6` and `window-padding-y = 4`. Starship: add `palette = "catppuccin_mocha"` and the `palettes.catppuccin_mocha` table to `programs.starship.settings`, keeping the existing `character` symbols. fastfetch: `config/fastfetch/config.jsonc` with mauve keys and the default module list, plus its `dots.nix` entry. Then report which of `btop`, `bat`, `kitty`, `tmux` under `config/` are already Mocha, changing none.

- [ ] **Step 6: Wallpaper, lock screen, SDDM**

Offer three or four Mocha-toned wallpapers in the visual companion; save the chosen one in `config/plasma/wallpapers/`. Set it as desktop wallpaper in `panels.js` (so a layout rebuild keeps it) and in `kscreenlockerrc`. In `system.nix`: add `(pkgs.catppuccin-sddm.override { flavor = "mocha"; accent = "mauve"; font = "Inter"; fontSize = "10"; })` to `environment.systemPackages` and set `services.displayManager.sddm.theme = "catppuccin-mocha-mauve"`. Confirm the override argument names against the package before writing them.

- [ ] **Step 7: Electron apps**

List installed Electron apps from `packages.nix`. For each with its own theming, name the Catppuccin theme and apply it only with the user's go-ahead.

- [ ] **Step 8: Rebuild, full check, acceptance**

`git add` new files, `nix flake check --no-build`, then ask the user to run `nh os switch` and log out and in. Run `bash config/plasma/check.sh` — expected every section `ok`. Walk the spec's six acceptance checks with the user.

- [ ] **Step 9: Commit**

```bash
git add config/plasma config/fastfetch config/zen config/ghostty nix/pc/configs
git commit -m "Theme GTK, Zen, terminal, lock screen and SDDM to match"
```
