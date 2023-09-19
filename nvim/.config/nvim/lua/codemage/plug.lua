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
            'hrsh7th/cmp-cmdline',

            -- Snippets and snippets completions
            {
                'L3MON4D3/LuaSnip',
                requires = { "rafamadriz/friendly-snippets" },
            }
        }
    }

    -- Treesitter
    --
    -- This plugin is a language parser that runs through code context,
    -- giving in things like file-based syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    -- Themes
    -- 
    use {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    }

    use({ 'rose-pine/neovim', as = 'rose-pine' })

    -- Git
    --
    -- Git integreation allows native use of Git in Vim, we could use things
    -- like G, Gdiff (for Git diff), and all
    use { 
        "tpope/vim-fugitive",
        "lewis6991/gitsigns.nvim"
    }

    -- Include other LSP sources
    --
    -- This plugin makes it possible to use external tools and treat them
    -- as sources that will be plugged into the LSP ecosystem.
    -- By using this in combination with Mason, I can add tools like Black
    -- without installing a dedicated Black plugin.
    use 'jose-elias-alvarez/null-ls.nvim'

    use {'nvim-lua/plenary.nvim'}
    -- Fuzzy finding for the meek
    --
    -- A bit of context here, we need away to quickly search through files
    -- Telescope is an extension that does just that, with fuzzy matching algo
    --
    -- I am taking advantage of FZF here to extend telescope capabilities
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        {
            'nvim-telescope/telescope-fzf-native.nvim', run = 'make'
        }
    }

    -- Debugging and Testing
    use {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui", 
        'vim-test/vim-test'
    }

    -- Others, brackets autopairing, comments 
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- 
    -- Terminal
    use {
        "akinsho/toggleterm.nvim", tag = '*', config = function()
            require("toggleterm").setup()
        end,
    }

    use {

        'akinsho/flutter-tools.nvim',
        -- Github Copilot -- testing
        'github/copilot.vim',
        -- Managing history with UndoTree
        'mbbill/undotree',
        -- Java
        'mfussenegger/nvim-jdtls',
        -- Vim with the cool tmux splits
        'christoomey/vim-tmux-navigator',
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
