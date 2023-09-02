-- [[ opts.lua]] --
--
-- Set user-defined settings for the editor in this file

local opt = vim.opt

opt.number = true
opt.relativenumber = true

-- whitespaces
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.expandtab = true

opt.scrolloff = 8

opt.backup = false
opt.writebackup = false
opt.swapfile = false

opt.clipboard = 'unnamedplus'
opt.showmode = false
opt.mouse = 'a'

-- search
opt.hlsearch = false

-- indent
opt.smartindent = true

-- splits
opt.splitbelow = true
opt.splitright = true
