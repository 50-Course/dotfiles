-- [[ init.lua ]] --

-- Gives vim the superpowers of efficient
-- modal editing (Sets the local leader and leader key to space)
vim.g.leader = ' '
vim.g.localleader = ' '

-- Make spacebar non-op when used by itself
vim.keymap.set('n', '<Space>', '<Nop>')

print 'Hello, @codemage'

-- TODO: [[
--  Setup Treesitter
--  Setup LsP configuration and Mason
--  Add Git integration with vim fugitive
--  Test runner with neo-test
--  Co-Pilot with git-copilot
--  ToggleTerm, Trouble, and Vim-tmux-navigator
--  Dart integration with Fluttertools
--  Plugin Management with Packer
--  Undo management with UndoTree
--  Formatting with null-ls
--  Debugging with nvim-dap and nvim-dap-ui
--  ]]
