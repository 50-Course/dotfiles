-- [[ remap.lua ]] --
--
-- User-defined keybindings

local keymap = vim.keymap
local opts = { silent = true, noremap = true }


local function cmd(string)
   return "<Cmd>"..string.."<cr>"
end


-- Quick save
-- Better way to save files
keymap.set('n', '<leader>w', cmd('w'), opts)

-- Quick exit
-- Better way to quit files 
keymap.set('n', '<leader>q', cmd('q'), opts)

-- Escape key remastered
-- hoping out of vim faster
keymap.set({'i', 't'}, 'jj', '<esc>l', opts)

-- you gonna love this, leader-X to make shell script to excutables? fill me in!

