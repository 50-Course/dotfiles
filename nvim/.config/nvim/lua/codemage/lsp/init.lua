local cmp = require("cmp")
local capabalities = vim.lsp.protocol.make_client_capabilities()
local luasnip = require("luasnip")

capabalities = require("cmp_nvim_lsp").default_capabilities(capabalities)

local mason = require("mason")
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-x>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping.confirm({
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
        { name = "luasnip" },
    }, {
        { name = "buffer" },
        { name = "path" },
    }),
})

-- Command-line completion

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

-- return the way cmp should be formatted for the lsp
local on_attach = function(client, bufnr)
    buffer = bufnr
    local map = vim.keymap.set

    map(
        "n",
        "gd",
        "<cmd>lua vim.lsp.buf.definition()<CR>",
        { noremap = true, silent = true, desc = "Goto definition" }
    )
    map("n", "<C-k>", vim.lsp.buf.signature_help, {
        noremap = true,
        silent = true,
        desc = "Show Signature Help",
        buffer = 0,
    })
    map(
        "n",
        "gD",
        "<cmd>lua vim.lsp.buf.declaration()<CR>",
        { noremap = true, silent = true, desc = "Goto declaration" }
    )
    map(
        "n",
        "gr",
        "<cmd>lua vim.lsp.buf.references()<CR>",
        { noremap = true, silent = true, desc = "Goto references" }
    )
    map(
        { "n", "v" },
        "<leader>f",
        "<cmd> lua vim.lsp.buf.formatting()<CR>",
        { noremap = true, silent = true, desc = "Format" }
    )
    map(
        "n",
        "<leader>rn",
        "<cmd>lua vim.lsp.buf.rename()<CR>",
        { noremap = true, silent = true, desc = "Rename Symbol" }
    )
    map(
        "n",
        "<leader>ca",
        "<cmd>lua vim.lsp.buf.code_action()<CR>",
        { noremap = true, silent = true, desc = "Code Action" }
    )
    map(
        "n",
        "gi",
        "<cmd>lua vim.lsp.buf.implementation()<CR>",
        { noremap = true, silent = true, desc = "Goto Implementation" }
    )
    map(
        "n",
        "K",
        vim.lsp.buf.hover,
        { buffer = 0, noremap = true, silent = true, desc = "Show Hover" }
    )
    map(
        "n",
        "<leader>D",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        { noremap = true, silent = true, desc = "Goto Type Definition" }
    )

    -- Diagonistic Keymaps
    map(
        "n",
        "<leader>dl",
        "<cmd>lua vim.diagnostic.open_float()<CR>",
        { noremap = true, silent = false, desc = "Open Diagnostic Buffer" }
    )
    map(
        "n",
        "<leader>dc",
        "<cmd>lua vim.lsp.diagnostic.clear(0)<CR>",
        { noremap = true, silent = true, desc = "Clear Diagnostics" }
    )
    map(
        "n",
        "<leader>da",
        "<cmd>lua vim.lsp.diagnostic.code_action()<CR>",
        { noremap = true, silent = true, desc = "Code Action" }
    )
end

local servers = {
    "clangd", -- C/C++
    "gopls", -- Go
    "pyright", -- Python
    "lua_ls", -- Lua
    "rust_analyzer", -- Rust
    "tsserver", -- TypeScript
    "dockerls", -- Docker
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

    ["lua_ls"] = function()
        local settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
            },
        }
        local opts = {
            on_attach = on_attach,
            capabilities = capabalities,
            settings = settings,
        }
        lspconfig["lua_ls"].setup(opts)
    end,
    ["gopls"] = function()
        local opts = {
            on_attach = on_attach,
            capabilities = capabalities,
            cmd = { "gopls" },
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                },
            },
        }
        lspconfig["gopls"].setup(opts)
    end,
})
