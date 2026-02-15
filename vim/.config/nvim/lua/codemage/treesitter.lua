-- codemage.treesitter.lua
-- Treesitter rewrite setup (new API)
--

-- Folding
-- vim.o.foldlevel = 0
-- vim.o.foldenable = true
-- vim.o.foldnestmax = 5

local filetypes = {
    "c",
    "cpp",
    "go",
    "javascript",
    "python",
    "rust",
    "java",
    "lua",
    "vimdoc",
    "vim",
}

require("nvim-treesitter").setup({
    -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
    install_dir = vim.fn.stdpath("data") .. "/site",
})

-- Enable Treesitter per filetype
vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        -- Start Treesitter
        vim.treesitter.start(bufnr)

        -- Folding
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"

        -- Indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

-- Open all folds by default
-- vim.o.foldlevelstart = 99

-- Highlighting: skip large files
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local ok, stats =
            pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
        if ok and stats and stats.size <= 1024 * 1024 then
            vim.treesitter.start(bufnr)
        end
    end,
})
