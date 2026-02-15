-- Packer is my favorite package manager
--
-- The plugin manager is currently unmaintained as of August 2023,
-- hence could generate some errors.
--
-- For convinence, you may want to follow the cool chads to use `lazy.nvim`
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data")
        .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

config = {
    profile = {
        enable = true,
        threshold = 1,
    },
}

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
    })

    use("nvim-lua/plenary.nvim")
    use("ThePrimeagen/harpoon")

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
    })

    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    -- Themes
    --
    -- I love Tokyonight, and Rose-pine (Just for that transp
    use({ "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} })
    use({ "rose-pine/neovim", as = "rose-pine" })

    use("wakatime/vim-wakatime")

    use("github/copilot.vim")
    use("mbbill/undotree")
    use("tpope/vim-fugitive")
    use("vim-test/vim-test")
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })

    -- Language Server Protocol
    --
    -- I use the `mason` for automatic installation of server protocols,
    -- `nvim-cmp` for completion, and `nvim-lspconfig` for configuration
    -- of the LSP.
    -- I also use `null-ls` for formatting and linting.
    use({
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    })
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
        },
    })
    -- friendly snippets for those vscode-like snippets
    use({
        "L3MON4D3/LuaSnip",
        tag = "v2.*",
        requires = {
            "saadparwaiz1/cmp_luasnip",
        },
    })
    use({ "rafamadriz/friendly-snippets" })
    use({
        "jose-elias-alvarez/null-ls.nvim",
    })

    -- Java development
    use("mfussenegger/nvim-jdtls")

    -- For debugging, I am using Nvim-dap and its UI
    use({
        "mfussenegger/nvim-dap",
        requires = { "rcarriga/nvim-dap-ui" },
    })

    if packer_bootstrap then
        require("packer").sync()
    end
end)
