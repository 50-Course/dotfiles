-- Unbind <Space> to Nop and to <Leader> key
vim.keymap.set("n", "<space>", "<nop>")

vim.g.mapleader = " "
vim.g.maplocalleader = ","

local keymap = vim.keymap

keymap.set("n", "<leader>w", "<cmd>w<cr>")
keymap.set("n", "<leader>q", "<cmd>q<cr>")
keymap.set({ "i", "v" }, "jk", "<esc>")
keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- Reload Vim with shortcut, `,,r`
keymap.set("n", "<localleader><localleader>r", "<cmd>source $MYVIMRC<cr>")
-- Make text selection move up and down in selection mode
keymap.set("v", "J", ":m '>+1<cr>gv=gv")
keymap.set("v", "K", ":m '<-2<cr>gv=gv")
-- Use <Ctrl-X'> to make a bash script executable
keymap.set("n", "<C-X>", "<cmd>silent !chmod +x %<cr>")
-- Keep cursor at the middle of the buffer at all times
-- ..when Ctrl+d is pressed to scroll to the bottom of the page
-- ..and when the reverse is done with Ctrl+u
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
-- Use system clipboard for text copying and pasting
keymap.set({ "n", "v" }, "<leader>y", '"+Y')
keymap.set("n", "<leader>p", '"dP')
keymap.set({ "n", "v" }, "<leader>d", '"_d')
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

--Git Integration
keymap.set("n", "<leader>gs", "<cmd>Git<cr>")
keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>")
keymap.set("n", "<leader>gp", "<cmd>Git push<cr>")
keymap.set("n", "<leader>gl", "<cmd>Git pull<cr>")
keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>")
keymap.set("n", "<leader>gd", "<cmd>Git diff<cr>")

-- Testing
keymap.set("n", "<leader>tn", "<cmd>TestNearest<cr>")
keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>")
keymap.set("n", "<leader>ts", "<cmd>TestSuite<cr>")
keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>")

