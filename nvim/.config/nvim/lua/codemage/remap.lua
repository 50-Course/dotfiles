-- [[ remap.lua ]] --
--
-- User-defined keybindings

local keymap = vim.keymap
local opts = { silent = true, noremap = true }


local function cmd(string)
   local cmd_arg = "<Cmd>"..string.."<cr>"

   return cmd_arg
end


-- Better way to save files
keymap.set('n', '<leader>w', cmd('w'), opts)

-- Better way to quit files 
keymap.set('n', '<leader>q', cmd('q'), opts)

-- hoping out of vim faster
keymap.set({'i', 't'}, 'jj', '<esc>l', opts)

