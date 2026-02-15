--- Defines the bindings for various operations performed by the LSP with combination of
--- chords.

local map = require("utils").remap
local M = {}

M.on_attach = function(client, bufnr)
  client = client
  buffer = bufnr

  -- Buffer options for LSP clients
  local opts = { noremap = true, silent = true }

  -- Keymaps for LSP
  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts, "[G]oto [d]efinition")
  map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts, "[G]oto [D]eclaration")
  map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts, "[J]ump to [I]impl")
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts, "[J]ump to [R]efrences")
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts, "Show Documentation")
  map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts, "Show [S]ignature")
  map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts, "[R]ename")
  map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts, "[C]ode [A]ction")
  map("n", "<leader>td", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts, "[T]ype [D]efinition")
end

return M
