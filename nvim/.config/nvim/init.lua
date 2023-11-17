------------------------------------------
--- PERSONAL DEVELOPMENT ENVIRONMENT
---
--- Author: Eri (@50Course/@codemage)
--- License: MIT License
------------------------------------------

local is_linux = vim.uv.os_uname().sys_name == "linux"
local is_macos = vim.uv.os_uname().sys_name == "darwin"

if is_macos then
    print("ERROR: Vim Conf not yet implemented")
elseif is_linux then
    print("ERROR: Vim Conf not yet implemented")
else
    print("ERROR: Vim Conf not yet implemented")
end

-- TODO: move this into the settings file
vim.g.netrw_banner = 0 -- Disable netrw banner (annoying)
require("codemage.settings")
require("codemage.plugins")
require("codemage.keymaps")
require("codemage.lsp")
