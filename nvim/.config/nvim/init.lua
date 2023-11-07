------------------------------------------
--- PERSONAL DEVELOPMENT ENVIRONMENT
---
--- Author: Eri (@50Course/@codemage)
--- License: MIT License
------------------------------------------

is_linux = vim.uv.os_uname().sys_name == "linux"
is_macos = vim.uv.os_uname().sys_name == "darwin"

if is_macos then
    return "ERROR: Vim Conf not yet implemented"
end

require("codemage.settings")
require("codemage.plugins")
require("codemage.keymaps")
require("codemage.lsp")
