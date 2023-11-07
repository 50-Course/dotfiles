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
vim.opt.completeopt = "menu,preview,noinsert,noselect"
vim.wo.scrolloff = 8
vim.wo.sidescrolloff = 7

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
