require("lualine").setup({
	options = {
		theme = "gruvbox-material",
		icons_enabled = true,
		disabled_filetypes = { "startify", "Outline", "plugins" },
	},
	sections = {
		lualine_a = { { "mode", upper = true } },
		lualine_b = { { "branch", icon = "" } },
		lualine_c = { { "diff", icon = "" }, { "filename" } },
		lualine_x = { { "location" }, { "progress" }, { "filetype", "fileformat" } },
		lualine_y = { { "nofixme#amount" } },
		lualine_z = { { "diagnostics", sources = { "nvim_diagnostic", "ale" }, sections = { "error", "warn", "info" } } },
	},
	extensions = { "fzf", "nvim-tree", "fugitive" },
})
