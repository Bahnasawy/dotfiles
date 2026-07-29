# Neovim

Personal [LazyVim](https://www.lazyvim.org/) configuration.

## Conventions

- Leader: `,`
- Local leader: `\\`
- Arrow keys move between windows.
- `m` deletes a character without replacing the unnamed register; `,m` saves.
- `w`, `e`, and `b` use `nvim-spider` word motions.
- `zR` and `zM` open and close all folds through `nvim-ufo`.

## Tooling

- TypeScript uses `vtsls`, `tsc.nvim`, and `oxfmt`.
- Nix uses `nixd` and `nixfmt`. Its flake options expect host-specific NixOS, nix-darwin, and Home Manager outputs.
- SQL support uses Dadbod and Dadbod UI. Open it with `,D`.
- CodeCompanion uses OpenCode. `,Cc` toggles chat, `,Ca` opens actions, and `,Ci` runs inline assistance on a visual selection.
- Markdown rendering is provided by LazyVim's `render-markdown.nvim` extra.

## Dependencies

Install language servers, formatters, and CLI tools through your system or Mason as appropriate. The Nix tooling requires `nixd` and `nixfmt`; TypeScript formatting requires `oxfmt`; the dashboard optionally uses `colorscript`.

## Flash Compatibility

`flash.nvim` is pinned to commit `70da6362c68772a6d2e316b691b701bf6b53936f`. Later revisions depend on a feature that was removed from Neovim nightly, so do not update this pin until Flash supports current nightly APIs again.
