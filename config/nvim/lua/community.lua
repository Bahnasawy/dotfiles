-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  { "AstroNvim/astrocommunity" },
  -- pack
  { import = "astrocommunity.pack.lua", ft = { "lua" } },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.nix" },
  -- colorscheme
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.oxocarbon-nvim" },
  { import = "astrocommunity.colorscheme.lackluster-nvim" },
  { import = "astrocommunity.colorscheme.cyberdream-nvim" },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  -- diagnostics
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
  -- editing-support
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.suda-vim" },
  { import = "astrocommunity.editing-support.telescope-undo-nvim" },
  { import = "astrocommunity.editing-support.vim-move" },
  { import = "astrocommunity.editing-support.cutlass-nvim" },
  -- register
  { import = "astrocommunity.register.nvim-neoclip-lua" },
  --debugging
  { import = "astrocommunity.quickfix.nvim-bqf" },
  -- fuzzy-finder
  { import = "astrocommunity.fuzzy-finder.telescope-zoxide" },
  -- completion
  { import = "astrocommunity.completion.supermaven-nvim" },
  -- utility
  { import = "astrocommunity.utility.telescope-lazy-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
  -- lsp
  { import = "astrocommunity.lsp.ts-error-translator-nvim" },
  -- recipes
  -- { import = "astrocommunity.recipes.neovide" },
  -- code-runner
  { import = "astrocommunity.code-runner.toggletasks-nvim" },
  -- bars and lines
  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
}
