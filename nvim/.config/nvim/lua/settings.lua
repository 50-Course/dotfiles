-- Vim Options
--
-- Vim adheres to strong defaults. To change this defaults, see https://neovim.io/doc/user/vim_diff.html#nvim-defaults

-- :h <options> would give you the options
--
vim.o.hidden = false
vim.o.hlsearch = false
vim.o.incsearch = true
vim.wo.number = true
vim.wo.relativenumber = true
-- Be smart about our search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Fat cursor is everything, what can I say? We pimp dhem holes ^_^
vim.opt.guicursor = ''
-- Yaay indenting!
-- Vim be smart about my indenting
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- Reduce Vim's update time
vim.opt.updatetime = 50
-- No fuckin' way would I tolerate text-wrapped
vim.opt.wrap = false
-- Talmabout good completion experience
vim.opt.completeopt = 'menuone,noselect,preview'

-- Set the number of reserved lines at the top and bottom before scrolling starts
vim.wo.scrolloff = 8

-- Highlight on cursor, when yanking
local highlight_text = vim.api.nvim_create_augroup('YankMeDaddy', {clear=true})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = highlight_text,
    callback = function() vim.highlight.on_yank() end,
    pattern = '*',
})

