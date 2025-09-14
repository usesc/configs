vim.o.number = true
vim.o.relativenumber = false

vim.o.swapfile = false
vim.o.writebackup = false
vim.o.undodir = vim.fn.stdpath("data") .. "/undo//"
vim.o.undofile = true
vim.o.backup = false

vim.o.cursorline = true

vim.o.tabstop = 8
vim.o.expandtab = false

vim.opt.clipboard = "unnamed"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{"Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end	
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
	{
		"navarasu/onedark.nvim",
		priority = 1000, -- load earliest
		config = function()
		require('onedark').setup {
			style = 'darker'
		}
		require('onedark').load()
		end
	},
	{ 
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
		require("nvim-treesitter.configs").setup { 
			ensure_installed = { "lua", "c", "rust" },
			highlight = { enable = true },
		} 
		end,
	},
	{ 
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function() require("nvim-tree").setup() end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{ 
		"romgrk/barbar.nvim",
		dependencies = {"nvim-tree/nvim-web-devicons",},
		init = function() vim.g.barbar_auto_setup = false end,
	},
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})

