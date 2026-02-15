--- Utility functions to aid development of other modules
---
--- @module utils
local M = {}

function M.get_sys_info()
    local sys_name = vim.loop.os_uname().sysname
    local sys_version = vim.loop.os_uname().version
    local sys_arch = vim.loop.os_uname().machine
    return sys_name, sys_version, sys_arch
end

function M.get_file_extension(path)
    return path:match("^.+(%..+)$")
end

function M.get_file_name(path)
    return path:match("^.+/(.+)$")
end

function M.get_file_path(path)
    return path:match("^(.+)/.+")
end

function M.inspect(obj)
    print(vim.inspect(obj))
end

return M
