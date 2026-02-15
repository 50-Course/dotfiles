local ok, null_ls = pcall(require, "null-ls")

if not ok then
    return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
    debug = false,
    sources = {
        formatting.rustfmt,
        formatting.clang_format,
        formatting.stylua,
        formatting.black.with({ extra_args = { "--fast" } }),
    },
})

-- Fomat Files on save
vim.cmd([[
    autocmd BufWritePre * lua vim.lsp.buf.format()
]])
