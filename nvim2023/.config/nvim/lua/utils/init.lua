--- Provide helper interfaces to aid usage of Vim APIs
---
--- Usage:
---
---     ```
---     local someModule = require('theModule')
---
---     -- n - Normal Mode
---     -- v - Visual Mode
---     -- x - Selection Mode
---
---     remap('n', '<leader>x', vim.cmd.Ex, '[O]pen [E]xplorer')
---     remap({'n', 'v'}, '<leader>x', vim.cmd.Ex, '[O]pen [E]xplorer')
---     ```
local M = {}

--- Maps a given key to given context with additional params
---
--- Context in here refers to what is been mapped, is it a function, a callback or what?
--- @param desc string Human-readable translation of provided mapping
--- @param mode string | table Vim's internal mode to map a context to
--- @param lhs string Key or chord to map a function, context to
--- @param rhs string Context being mapped to
M.remap = function(mode, lhs, rhs, buffopts, desc)
  if desc then buffopts.desc = desc or "" end

  vim.keymap.set(mode, lhs, rhs, buffopts)
end

return M
