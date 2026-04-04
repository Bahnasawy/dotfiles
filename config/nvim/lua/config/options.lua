-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.o.shell = "/etc/profiles/per-user/" .. os.getenv("USER") .. "/bin/nu"

vim.g.lazyvim_blink_main = true

vim.diagnostic.config({
	update_in_insert = false, -- key setting
})

vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
-- vim.g.lazyvim_rust_diagnostics = "bacon-ls"
