------------------------------------------
--- PERSONAL DEVELOPMENT ENVIRONMENT
---
--- Author: Eri (@50Course/@codemage)
--- License: MIT License
------------------------------------------

local is_win = vim.uv.os_uname().sys_name == "Windows"
local is_macos = vim.uv.os_uname().sys_name == "darwin"

if is_macos then
    print("ERROR: Vim Conf not yet implemented")
elseif is_win then
    print("ERROR: Vim Conf not yet implemented")
end

-- TODO: move this into the settings file
vim.g.netrw_banner = 0 -- Disable netrw banner (annoying)
vim.g.loaded_python3_provider = 0

require("codemage.settings")
require("codemage.plugins")
require("codemage.keymaps")
require("codemage.lsp")
