local map = vim.api.nvim_set_keymap
local opts = { expr = true, silent = true }

vim.g.copilot_no_tab_map = true

map("i", "<C-J>", 'copilot#Accept("<CR>")', opts)
map("i", "<C-H>", 'copilot#Previous()', opts)
map("i", "<C-K>", 'copilot#Next()', opts)
