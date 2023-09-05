-- [[ plug.lua ]] --

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

-- auto-update packer upon file change
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])


-- dependencies/plugins 
local function spec(use) 
  use 'wbthomason/packer.nvim'

  -- LSP
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    -- Completions
    {
        "saadparwaiz1/cmp_luasnip",
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/nvim-cmp',

        -- Snippets and snippets completions
        {
            'L3MON4D3/LuaSnip'
            'saadparwaiz1/cmp_luasnip'
        }
    }
  }

  -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,

        -- Making treesitter more smarter
        {
        "nvim-treesitter/nvim-treesitter-textobjects"
        }
    }
  
  -- themes
    use {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    }

    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

   if packer_bootstrap then
       require('packer').sync()
   end
end


return require('packer').startup {
    spec,
}
