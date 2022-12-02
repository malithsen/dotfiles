local g = vim.g
local api = vim.api

g.fzf_colors = {
	fg = { "fg", "Normal" },
	bg = { "bg", "Normal" },
	hl = { "fg", "Comment" },
	["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
	["bg+"] = { "bg", "CursorLine", "CursorColumn" },
	["hl+"] = { "fg", "Statement" },
	info = { "fg", "PreProc" },
	border = { "fg", "Ignore" },
	prompt = { "fg", "Conditional" },
	pointer = { "fg", "Exception" },
	marker = { "fg", "Keyword" },
	spinner = { "fg", "Label" },
	header = { "fg", "Comment" },
}

vim.api.nvim_exec(
	[[
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case --glob "!{.git,node_modules,flow-typed}" -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
]],
	""
)

api.nvim_set_keymap("n", "<Space>h", ":FzfLua oldfiles<CR>", { noremap = true })
api.nvim_set_keymap("n", "<Space>bb", ":FzfLua buffers<CR>", { noremap = true })
api.nvim_set_keymap("n", "<Space>ff", ":FzfLua files<CR>", { noremap = true })
api.nvim_set_keymap("n", "<Space>pf", ":FzfLua git_files<CR>", { noremap = true })
-- api.nvim_set_keymap("n", "<Space>p/", "<ESC>:Rg<CR>", { noremap = true, silent = false })
-- api.nvim_set_keymap("n", "<Space>/", "<ESC>:Rg <C-R><C-W><CR>", { noremap = true, silent = false })
api.nvim_set_keymap("n", "<Space>p/", ":FzfLua grep_project<CR>", { noremap = true, silent = false })
api.nvim_set_keymap("n", "<Space>/", ":FzfLua grep_cword<CR>", { noremap = true, silent = false })
api.nvim_set_keymap("n", "<Space>v/", ":FzfLua grep_visual<CR>", { noremap = true })
