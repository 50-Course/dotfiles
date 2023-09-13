-- [[ opts.lua]] --
--
-- Set user-defined settings for the editor in this file
--
-- Consult the help documentation for settings that is unclear to you,
-- `:h vim.opt` or `:h [setting]` would display relevant documentation
--
-- e.g: `:h tabstop` or `:h clipboard`

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

-- better completion experience
--
-- menu: allows pop-up upon entering some text
-- preview: display extra information about selected completion
-- noselect: forces user to select a suggestion, setting default to false
opt.completeopt = 'menu,menuone,noselect'
