local ok, null_ls = pcall(require, "null-ls")

if not ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = false,
    sources = {
        formatting.rustfmt,
        formatting.clang_format,
        formatting.stylua,
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.shfmt,
        diagnostics.flake8,
    },
})

-- Fomat Files on save
vim.cmd([[
    autocmd BufWritePre * lua vim.lsp.buf.format()
]])
