--- Utility functions to aid development of other modules
---
--- @module utils
local M = {}

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
