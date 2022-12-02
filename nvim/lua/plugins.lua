local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd("packadd packer.nvim")
end

-- require("packer.luarocks").setup_paths()
return require("packer").startup(function(use, use_rocks)
	use("wbthomason/packer.nvim")
	use_rocks({ "lualogging" })

	use({ "sainnhe/gruvbox-material" })

	-- Highlights
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"nvim-treesitter/nvim-treesitter-refactor",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		run = ":TSUpdate",
		config = [[require("plugins.treesitter")]],
	})

	--
	-- LSP
	--

	-- "onsails/lspkind-nvim" try??
	use({

		"neovim/nvim-lspconfig",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"ray-x/lsp_signature.nvim",
		},
		config = [[require("plugins.lsp")]],
	})
	use({
		"nvim-lua/lsp_extensions.nvim",
		requires = { "neovim/nvim-lspconfig" },
	})

	use({
		-- glepnir/lspsaga is not maintained anymore. Might need a better alternative
		"tami5/lspsaga.nvim",
		requires = { "neovim/nvim-lspconfig" },
		config = function()
			require("lspsaga").init_lsp_saga()
		end,
	})

	-- Linting, autoformatting…
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
		},
	})

	use({
		"simrat39/rust-tools.nvim",
		requires = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("rust-tools").setup({
				server = {
					on_attach = require("plugins.utils").on_attach,
				},
			})
		end,
	})

	use({
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({ default = true })
		end,
	})

	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({})
		end,
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	--
	-- Completion
	--
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = [[require("plugins.cmp")]],
	})

	--
	-- Finding stuff
	--
	use({
		{
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
				"telescope-frecency.nvim",
				"telescope-fzf-native.nvim",
			},
			config = [[require("plugins.telescope")]],
			cmd = "Telescope",
			module = "telescope",
		},
		{
			"nvim-telescope/telescope-frecency.nvim",
			after = "telescope.nvim",
			requires = "tami5/sql.nvim",
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
		},
	})
	use({
		"junegunn/fzf",
		run = "./install --bin",
		config = [[require("plugins.fzf")]],
	})
	use({
		"junegunn/fzf.vim",
		config = [[require("plugins.fzf")]],
	})

	use("ibhagwan/fzf-lua")

	--
	-- Git
	--
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	})
	use({
		"TimUntersberger/neogit",
		cmd = "Neogit",
		disable = true,
	})

	--
	-- Status/Tab line
	--

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = [[require("plugins.statusline")]],
	})

	use({
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = [[require("plugins.tabline")]],
	})

	--
	-- colorschemes
	--
	use({ "lifepillar/vim-gruvbox8", event = "VimEnter" })
	use({ "shaunsingh/nord.nvim", event = "VimEnter" })
	use({ "NTBBloodbath/doom-one.nvim", event = "VimEnter" })
	use({ "sainnhe/everforest", event = "VimEnter" })

	use("godlygeek/tabular")
	use("junegunn/vim-easy-align")

	use({
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({})
		end,
	})

	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		requires = {
			"tpope/vim-commentary",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				context_commentstring = {
					enable = true,
				},
			})
		end,
	})

	--
	-- file explorer
	--
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({
				disable_netrw = false,
				hijack_netrw  = false,
				view = {
					side = "right",
				},
			})
		end,
	})

	use({
		"mickael-menu/zk-nvim",
		config = function()
			require("gitsigns").setup()
			require("zk").setup({
				picker = "fzf",

				lsp = {
					config = {
						cmd = { "zk", "lsp" },
						name = "zk",
						-- on_attach = ...
						-- etc, see `:h vim.lsp.start_client()`
					},

					-- automatically attach buffers in a zk notebook that match the given filetypes
					auto_attach = {
						enabled = true,
						filetypes = { "markdown" },
					},
				},
			})
		end,
	})

	use("tpope/vim-fugitive")
	use("tpope/vim-repeat")
	use("tpope/vim-surround")
	use("tpope/vim-eunuch")
	use("tpope/vim-rhubarb")
	use("mhinz/vim-startify")
	use("michaeljsmith/vim-indent-object")
	use("jiangmiao/auto-pairs")
	use("kchmck/vim-coffee-script")
	use("jesseleite/vim-agriculture")
	use("ggandor/lightspeed.nvim")
	use("junegunn/goyo.vim")
	use("vimwiki/vimwiki")
end)
