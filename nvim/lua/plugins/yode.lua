local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

require("yode-nvim").setup({})
map("n", "<Space>yc", ":YodeCreateSeditorFloating<CR>", opts)
map("n", "<Space>yd", ":YodeBufferDelete<CR>", opts)
-- these commands fall back to overwritten keys when cursor is in split window
map("n", "<C-w>r", ":YodeLayoutShiftWinDown<CR>", opts)
map("n", "<C-w>R", ":YodeLayoutShiftWinUp<CR>", opts)
map("n", "<C-w>J", ":YodeLayoutShiftWinBottom<CR>", opts)
-- map <C-W>r :YodeLayoutShiftWinDown<CR>
-- map <C-W>R :YodeLayoutShiftWinUp<CR>
-- map <C-W>J :YodeLayoutShiftWinBottom<CR>
-- map <C-W>K :YodeLayoutShiftWinTop<CR>
