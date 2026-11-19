# Plasma rice for `pc`: design

Date: 2026-11-19
Host: `pc` (NixOS 26.11, Plasma 6.8.2, Wayland, one 3440×1440 display at 1× scale)

## Goal

A Catppuccin Mocha desktop where the running app owns the whole screen and
everything else appears only when reached for.

Success looks like this:

- At rest, the screen shows only the app: no title bar, no panels, no menu bar.
- Pushing the pointer to the left, right or top edge slides in a slim,
  translucent panel.
- Panels, app widgets, menus and popups share one shape language: about 3px
  corner radius, very little padding. Not boxy, not pill-shaped.
- All rice configuration lives in `~/dotfiles/config/` and is symlinked, so
  edits apply without a Nix rebuild.

## Decisions

| Topic | Decision |
|---|---|
| Palette | Catppuccin Mocha |
| Accent | Mauve `#cba6f7` |
| Panel finish | Translucent with blur ("tight, translucent") |
| Corner radius | ~3px everywhere |
| Padding | Minimal: ~3px gap from screen edge, tight inner spacing |
| Panels | Left rail, right rail, top menu bar; all auto-hide |
| Windows | Open maximized and borderless by default |
| Interface font | Inter |
| Monospace font | JetBrainsMono Nerd Font (already installed) |
| Config management | Files in `config/plasma/`, per-file symlinks via `dots.nix` |
| Build approach | Configurable components, not hand-drawn theme art |

### Why symlinked files rather than plasma-manager

plasma-manager does not cover all of Plasma's settings. Keeping every setting
in real config files gives full coverage and live edits. plasma-manager stays
loaded for the host, but the rice does not use it for appearance.

### Why configurable components

Radius, padding and opacity are plain values in text files, which suits the
symlinked-folder model and makes tuning a one-number change. The alternatives
were hand-editing Plasma style, Aurorae and Kvantum SVGs (slow, brittle across
Plasma releases) or stock Catppuccin ports (rounder and roomier than wanted,
with no settings to change that).

## Components

| Surface | Component | nixpkgs attribute |
|---|---|---|
| Panel shape, margins, opacity, blur | Panel Colorizer | `plasma-panel-colorizer` |
| Qt widget style | Darkly | `darkly` |
| Window corners and focus outline | KDE Rounded Corners | `kde-rounded-corners` |
| App name and window buttons in a panel | Application Title Bar | `application-title-bar` |
| Interface font | Inter | `inter` |
| Icons | Papirus-Dark with Mocha mauve folders | `catppuccin-papirus-folders` |
| Cursor | Catppuccin Mocha Dark | `catppuccin-cursors` |
| Login screen | Catppuccin SDDM, Mocha mauve | `catppuccin-sddm` |

All were confirmed present in the nixpkgs revision the system currently runs
(`f9a75f4`). `flake.lock` has an uncommitted update to a newer revision; the
attributes must be re-checked against it at the first rebuild.

## Section 1: File layout and wiring

New folder `config/plasma/`:

```
config/plasma/
├── kdeglobals            colors in use, fonts, icon theme, widget style
├── kwinrc                borderless-maximized, effects, corner plugin settings
├── kwinrulesrc           the open-maximized rule
├── plasmarc              Plasma style selection
├── plasmashellrc         panel thickness, auto-hide
├── plasma-org.kde.plasma.desktop-appletsrc    panels and their widgets
├── darklyrc              widget style: radius, spacing
├── kcminputrc            cursor theme
├── kscreenlockerrc       lock screen
├── color-schemes/CatppuccinMochaMauve.colors
├── panel-colorizer/      the tight-glass panel preset
├── gtk/                  gtk.css override for GTK 3 and 4
└── wallpapers/
```

Further folders: `config/fastfetch/`, `config/zen/`.

Wiring:

- Each file gets a `home.file` entry in `nix/pc/configs/dots.nix` using
  `config.lib.file.mkOutOfStoreSymlink` with an absolute
  `/home/bahnasawy/dotfiles/...` path. These are per-file links, because
  Plasma's files sit loose in `~/.config`.
- The live files are copied into `config/plasma/` first, so the tiling layout,
  keyboard layouts, shortcuts and power settings carry over. The originals are
  backed up before being replaced by links.

Nix changes, kept minimal:

- `nix/pc/configs/packages.nix`: add the packages above. Remove
  `colorScheme`, `theme` and `lookAndFeel` from `programs.plasma.workspace`,
  since they would overwrite the symlinked files on each rebuild. Move the
  keyboard-layout and power settings from `programs.plasma` into the
  symlinked files so there is one source of truth, then drop the
  `programs.plasma` block.
- `nix/pc/configs/dots.nix`: the new symlink entries.
- `nix/pc/configs/system.nix`: Inter in `fonts.packages`; SDDM theme.
- `programs.starship.settings` (already in Nix): Mocha palette.

Risks and handling:

- **Symlinks replaced by regular files.** Plasma rewrites these files while
  running. Milestone 1 tests that each link survives a settings change made in
  System Settings, a logout and login, and a rebuild. Any file that fails the
  test is taken out of `dots.nix` and handled instead by
  `config/plasma/apply.sh`, which writes that file's keys with `kwriteconfig6`
  from values kept in `config/plasma/`.
- **Noisy diffs.** `kwinrc` and the applets file also hold machine state such
  as screen IDs. This is accepted. Commits are made deliberately at each
  milestone.

## Section 2: Desktop shell

### Window behavior

- One KWin rule in `kwinrulesrc` matches all normal windows and sets
  maximized horizontally and vertically with "Apply Initially". Dialogs,
  utility windows and popups are excluded. Windows can still be un-maximized
  and tiled; the existing 25/50/25 tiling layout is kept.
- `BorderlessMaximizedWindows=true` in `kwinrc` removes the title bar and
  border from maximized windows.
- This is maximized-and-borderless, not KWin's fullscreen mode. It looks the
  same and keeps screen-edge panel reveal working. The real fullscreen
  shortcut is left alone.
- Non-maximized windows: slim Mocha title bar, 3px corners and a thin mauve
  outline on the focused window, via KDE Rounded Corners.
- The top-left Overview hot corner is disabled. Overview stays on its
  keyboard shortcut.

### Panels

All three auto-hide and share one Panel Colorizer preset: Mocha surface at
about 78% opacity with blur, 3px radius, 3px gap from the screen edge, 1px
subtle border, tight inner spacing. Starting values, tuned live.

| Panel | Size | Contents, in order |
|---|---|---|
| Left rail | ~46px wide, full height | App launcher · icons-only task manager (mauve marker on the active app) · spacer · virtual desktop pager |
| Right rail | ~46px wide, full height | Clock and date · spacer · system tray (network, volume, bluetooth, KDE Connect, clipboard, keyboard layout, notifications) · lock/logout |
| Top bar | ~30px tall, inset between the rails | Active app name · global menu · spacer · minimize, maximize, close |

- Each panel reveals when the pointer touches its edge. Reveal delay is tuned
  to avoid accidental triggers.
- The Meta key opens the launcher while the rail is hidden.
- The top bar is inset so the three trigger zones do not overlap at the top
  corners.

Known limit: the global menu shows menus for Qt and KDE apps. Zen, Firefox
and Electron apps do not export menus on Wayland; for those the top bar shows
the app name and window buttons only.

## Section 3: App appearance

### Colors

`CatppuccinMochaMauve.colors` is the single color source for Plasma and Qt
apps. It is written from the official Catppuccin palette, not taken from the
`catppuccin-kde` package, which builds with a blue accent by default.

- View background: base `#1e1e2e`. Window, sidebar and toolbar background:
  mantle `#181825`. Deepest layer: crust `#11111b`.
- Text: text `#cdd6f4`. Inactive text: subtext0 `#a6adc8`.
- Selection, focus, links, default buttons: mauve `#cba6f7`.
- Negative: red `#f38ba8`. Neutral: yellow `#f9e2af`. Positive: green
  `#a6e3a1`.

### Widget style (Darkly)

- 3px radius for buttons, inputs, menus, tooltips, tabs and popups.
- Compact toolbar and menu-item padding; slim scrollbars that widen on hover.
- Menus and popups slightly translucent with blur. Main window backgrounds
  stay opaque.
- No frame lines around sidebars and toolbars; areas are separated by the
  base/mantle shade difference.

### Fonts

| Use | Font | Size |
|---|---|---|
| General, menus, toolbars | Inter | 10pt |
| Small | Inter | 8pt |
| Window titles | Inter Medium | 10pt |
| Fixed width | JetBrainsMono Nerd Font | 10pt |

Arabic text falls back to Noto.

### Icons and cursor

- Papirus-Dark with Catppuccin Mocha mauve folders.
- Catppuccin Mocha Dark cursor at 24px.

## Section 4: Extras

### Non-KDE apps

- GTK 3 and 4: Breeze GTK, which Plasma recolors from the active color
  scheme, plus a `gtk.css` override for 3px corners. `catppuccin-gtk` is not
  used because it is archived upstream.
- Zen: Catppuccin Mocha mauve theme in `config/zen/`, linked into the profile.
- Firefox: the Catppuccin Mocha mauve theme, installed by hand.
- Electron apps: follow the system dark preference. Apps with their own
  theming are listed at build time and themed one by one.
- GTK menu export to the top bar is tested but not a requirement.

### Terminal

- Ghostty: already Mocha with JetBrainsMono. Add small window padding.
- Starship: Mocha palette, in the existing Nix settings.
- fastfetch: Mocha config in `config/fastfetch/`.
- `btop`, `bat`, `kitty`, `tmux`: check whether they are already Mocha and
  report. No changes without asking.

### Login, lock screen, wallpaper

- Lock screen: Mocha colors, Inter, the chosen wallpaper.
- SDDM: `catppuccin-sddm`, Mocha mauve, set in `system.nix`. SDDM cannot read
  the home folder. Auto-login is on, so it is rarely seen.
- Wallpaper: three or four Mocha-toned candidates are offered at build time.

## Build order

One commit per milestone.

1. Snapshot live config into `config/plasma/`; add packages and links;
   rebuild; run the symlink-survival test.
2. Color scheme, fonts, icons, cursor.
3. Darkly widget style.
4. Window behavior: maximize rule, borderless, corners.
5. The three panels.
6. Extras: non-KDE apps, terminal, lock screen, SDDM, wallpaper.

Rebuilds need sudo and are run by the user.

## Verification

At each milestone:

- A screenshot is taken and compared with this design.
- The user confirms on the real screen; values are tuned before moving on.

After milestones 1 and 5, a logout and login plus a rebuild confirm that
settings persist and the files are still symlinks.

Acceptance checks for the finished rice:

- A newly opened app covers all 3440×1440 pixels with no title bar.
- Each of the three edges reveals its panel, and the panel hides on leave.
- Dolphin shows its menus in the top bar.
- A dialog opens at its natural size, with 3px corners.
- `ls -l` on every file listed in Section 1 shows a link into
  `~/dotfiles/config/`, or the file is listed in `apply.sh`.
- `git status` in `~/dotfiles` is clean after a logout and login, apart from
  machine-state churn in `kwinrc` and the applets file.

## Rollback

- Every milestone is one git commit and can be reverted on its own.
- The original `~/.config` files are backed up in milestone 1.
- Applying the Breeze Dark global theme restores a stock look mid-session.

## Out of scope

- Other hosts (`laptop`, `usb`, `mac`).
- Porting the rice to plasma-manager.
- Keyboard shortcut changes beyond disabling the top-left hot corner.
- KWin tiling scripts or a tiling window manager.
