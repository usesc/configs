vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.clipboard = "unnamed"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
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
    { "folke/tokyonight.nvim",
      lazy = false, 
      priority = 1000,
      config = function() vim.cmd([[colorscheme tokyonight]]) end,
    },
    { "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup { 
          ensure_installed = { "lua", "c", "rust" },
          highlight = { enable = true },
        } 
      end, 
    },
    { "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function() require("nvim-tree").setup() end,
    },
    { "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true,
    },
    { "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = true,
    },
    { "romgrk/barbar.nvim",
      dependencies = {"nvim-tree/nvim-web-devicons",},
      init = function() vim.g.barbar_auto_setup = false end,
    },
    {"akinsho/toggleterm.nvim", version = "*", config = true},
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

