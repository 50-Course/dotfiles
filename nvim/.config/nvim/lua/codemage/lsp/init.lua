local cmp = require("cmp")

local capabalities = vim.lsp.protocol.make_client_capabilities()
capabalities = require("cmp_nvim_lsp").default_capabilities(capabalities)
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = nil,
        ["<S-Tab>"] = nil,
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "lua_snip" },
    }, {
        { name = "buffer" },
        { name = "path" },
    }),
})

local on_attach = function(client, bufnr)
    buffer = bufnr
    local map = vim.keymap.set

    map(
        "n",
        "gd",
        "<cmd>lua vim.lsp.buf.definition()<CR>",
        { noremap = true, silent = true }
    )
    map(
        "n",
        "gD",
        "<cmd>lua vim.lsp.buf.declaration()<CR>",
        { noremap = true, silent = true }
    )
    map(
        "n",
        "gr",
        "<cmd>lua vim.lsp.buf.references()<CR>",
        { noremap = true, silent = true }
    )
    map(
        { "n", "v" },
        "<leader>f",
        "<cmd> lua vim.lsp.buf.formatting()<CR>",
        { noremap = true, silent = true }
    )
    map(
        "n",
        "<leader>rn",
        "<cmd>lua vim.lsp.buf.rename()<CR>",
        { noremap = true, silent = true }
    )
    map(
        "n",
        "<leader>ca",
        "<cmd>lua vim.lsp.buf.code_action()<CR>",
        { noremap = true, silent = true }
    )
    map(
        "n",
        "<leader>K",
        "<cmd>lua vim.lsp.buf.hover()<CR>",
        { noremap = true, silent = true }
    )
    map(
        "n",
        "<leader>td",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        { noremap = true, silent = true }
    )
end

local servers = {
    "clangd", -- C/C++
    "gopls", -- Go
    "pyright", -- Python
    "lua_ls", -- Lua
    "rust_analyzer", -- Rust
}

mason.setup()
mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
})
mason_lspconfig.setup_handlers({
    -- Automatically configure servers installed via `:MasonInstall or :Mason `
    function(server_name)
        require("lspconfig")[server_name].setup({
            on_attach = on_attach,
            capabilities = capabalities,
        })
    end,
})
