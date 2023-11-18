-- Vim Options
--
-- Vim adheres to strong defaults. To change this defaults, see https://neovim.io/doc/user/vim_diff.html#nvim-defaults

-- :h <options> would give you the options
--
vim.o.hidden = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.guicursor = ""
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.updatetime = 50
vim.opt.wrap = false
vim.opt.completeopt = "menuone,preview,noselect"
vim.wo.scrolloff = 8
vim.wo.sidescrolloff = 7
vim.opt.swapfile = false

vim.opt.undodir = vim.fn.expand("~/.config/nvim/undodir")
vim.opt.undofile = true

vim.opt.termguicolors = true

-- ********************************************************
-- Highlight on cursor, when yanking
local highlight_text =
    vim.api.nvim_create_augroup("YankMeDaddy", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = highlight_text,
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = "*",
})

-- Jump to last location when reopening a file
local jump_to_last_location =
    vim.api.nvim_create_augroup("JumpToLastLocation", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
    group = jump_to_last_location,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- ********************************************************

vim.g["test#strategy"] = "neovim"
vim.g["test#neovim#term_repl_open_cmd"] = "vsplit"
vim.g["test#neovim#term_position"] = "vert"
vim.g["#test#custom_runners"] = {
    {
        name = "pytest",
        cmd = { "pytest", "-s", "-vv", "-x", "--ff", "-k" },
        tempfile_pattern = {
            "test_*.py",
            "tests_*.py",
            "*_test.py",
            "tests.py",
        },
    },
}
