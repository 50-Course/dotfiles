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
    use("jose-elias-alvarez/null-ls.nvim")
    use("tpope/vim-fugitive")
    use("vim-test/vim-test")
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })

    if packer_bootstrap then
        require("packer").sync()
    end
end)
