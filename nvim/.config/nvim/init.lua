print("Welcome to Vim, @codemage")


vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { silent = true } )


require('codemage.opts')
require('codemage.remap')
require('codemage.plug')
