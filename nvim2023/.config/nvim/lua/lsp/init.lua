local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args) require("luasnip").lsp_expand(args.body) end,
  },
  mapping = cmp.mapping.preset.insert({
    -- Scroll docs backwards
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    -- Scroll docs forwards
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    -- Open completion menu
    ["<C-Space>"] = cmp.mapping.complete(),
    -- Close completion menu
    ["<C-e>"] = cmp.mapping.abort(), -- understood as Escape-completion
    -- Accept completion option
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" }, -- For luasnip users.
  }, {
    { name = "buffer" },
  }),
})

-- Set up lspconfig.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
--
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
local servers = {
  "clangd", -- C
  "gopls", -- Go
  "pyright", -- Python
  "lua_ls", -- Lua
  "rust_analyzer", -- Rust
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- LANGUAGE SERVER CONFIGURATIONS
--
-- Language specific setup
local lspconfig = require("lspconfig")
local lsp_keymaps = require("lsp.keymaps")

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
})

lspconfig.pyright.setup({ capabilities = capabilities, on_attach = lsp_keymaps.on_attach })
lspconfig.rust_analyzer.setup({ capabilities = capabilities, on_attach = lsp_keymaps.on_attach })
lspconfig.gopls.setup({ capabilities = capabilities, on_attach = lsp_keymaps.on_attach })
lspconfig.clangd.setup({ capabilities = capabilities, on_attach = lsp_keymaps.on_attach })
