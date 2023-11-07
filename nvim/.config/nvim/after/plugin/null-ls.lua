local ok, null_ls = pcall(require, "null-ls")

if not ok then
    return
end

local format_sources = {
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.lua_format,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.shfmt,
}

local diag_sources = {
    null_ls.builtins.diagnostics.mypy,
}

null_ls.setup({
    sources = format_sources,
})
