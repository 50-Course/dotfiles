local ok, null_ls = pcall(require, "null-ls")

if not ok then return end

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.ruff,
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.stylua,
  },
})
