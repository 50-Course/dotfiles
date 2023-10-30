-- Packer is my favorite package manager
--
-- The plugin manager is currently unmaintained as of August 2023,
-- hence could generate some errors.
--
-- For convinence, you may want to follow the cool chads to use `lazy.nvim`
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Treesitter
  --
  -- Language parser that provides highlighting, errors, jump to definitions, etc
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/nvim-treesitter-textobjects')

  -- Harpoon for quick files navigation
  use('nvim-lua/plenary.nvim')
  use('ThePrimeagen/harpoon')

  -- Fuzzy-searching with Telescope
  use {
      'nvim-telescope/telescope.nvim', tag = '0.1.4',
      -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
  }
  -- Comments are just awesome
  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }

  -- Themes
  --
  -- I love Tokyonight
  use { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {}, }

  -- Language Server and its essentials
  --
  -- Completion engines, snippets, and lsp manager
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  -- autocompletion support for lsp
  -- Autocompletion
  use {
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      "saadparwaiz1/cmp_luasnip",
  }
  use {'L3MON4D3/LuaSnip'

  } -- snippet engine

  -- Wakatime
  use 'wakatime/vim-wakatime'

  -- git integration, surrounds and copilot
  use 'tpope/vim-fugitive'
  use "tpope/vim-surround"
  use "github/copilot.vim"

  -- TODO: Debugging with Nvim DAP & DAP UI
  -- TODO: Tests with Vim-test
  -- TODO: Linter and Formatter with NullLS
  use "jose-elias-alvarez/null-ls.nvim" 

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
