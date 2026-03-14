-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

map("n", "<Left>", "<C-w>h", { desc = "Go to Left Window", remap = false })
map("n", "<Down>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<Up>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<Right>", "<C-w>l", { desc = "Go to Right Window", remap = true })

map("n", "<leader>m", ":w<cr>", { desc = "Save File", silent = true })
map("n", "m", "x")
