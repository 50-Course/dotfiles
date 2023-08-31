print("Welcome to Vim, @codemage")


vim.g.leader = ' '
vim.g.localleader = ' '
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { silent = true } )


require('codemage.opts')
