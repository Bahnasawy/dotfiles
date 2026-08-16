# AGENTS.md

Personal dotfiles for **Yousef Elbahnasawy**, managed with **Nix flakes + home-manager**. Dotfiles under `config/` are symlinked into `~/.config` by the Nix configs.

## Repository layout

- `config/` — application configs, symlinked via `mkOutOfStoreSymlink` in each host's `dots.nix`. Most are editors/tools:
  - `nvim` (LazyVim), `tmux`, `kitty`, `ghostty`, `yazi`, `bat`, `sesh`, `herdr`, `opencode`, `tuicr`, `git`, `gh-dash`, `raycast` (macOS only)
- `nix/` — Nix flake with per-host configs:
  - `flake.nix` — inputs and all machine definitions
  - `<host>/configuration.nix` — NixOS/nix-darwin system config
  - `<host>/home.nix` — home-manager config
  - `<host>/configs/` — `system.nix`, `packages.nix`, `dots.nix` (symlink setup), and host-specific extras (`plasma.nix`, `homebrew.nix`)

## Hosts (defined in `nix/flake.nix`)

| Host     | Platform                | User         |
|----------|-------------------------|--------------|
| `pc`     | NixOS, x86_64-linux     | bahnasawy    |
| `usb`    | NixOS, x86_64-linux     | bahnasawy    |
| `p2`     | NixOS (WSL)             | brandon      |
| `wsl`    | NixOS (WSL)             | bahnasawy    |
| `laptop` | home-manager, x86_64    | —            |
| `mac`    | nix-darwin, aarch64     | bahnasawy    |

## Key conventions & gotchas

- **Path differences:** Linux hosts reference `/home/bahnasawy/dotfiles`; macOS uses `/Users/bahnasawy/dotfiles`. Keep paths absolute and host-correct in `dots.nix`.
- **Dotfile symlinks:** `config/` entries are NOT managed directly by home-manager; they are symlinked as whole directories with `recursive = true`. To add a new dotfile, add a `home.file` entry in the host's `dots.nix`, then rebuild.
- New tool configs should go under `config/<tool>/` and be wired into `dots.nix` for the hosts that use them.
- Package lists live in `nix/<host>/configs/packages.nix`; system-level tuning in `system.nix`.
- `stateVersion`: `pc` is `26.11`, `mac` is `26.05` — do not change unless deliberately bumping.
- `config/opencode/` has a local `node_modules` (contains `@opencode-ai/plugin`) and `package.json`.
- `.zprofile` holds macOS-only env exports (Homebrew paths, `OLLAMA_CONTEXT_LENGTH`); Zsh config itself was moved into Nix.
- The repo also carries a `.jj` (Jujutsu) working copy.

## Validation

- Structure/format check a host config:
  ```sh
  nix flake check --no-build
  ```
- Test-build a specific host (e.g. PC):
  ```sh
  nix build .#nixosConfigurations.pc.config.system.build.toplevel
  ```
- After changing `config/` dotfiles, no Nix rebuild is needed on machines where they are symlinked — changes apply immediately.
