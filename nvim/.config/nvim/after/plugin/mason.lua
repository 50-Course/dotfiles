-- Mason manages my automatic installation of language servers

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

local servers = {
    'gopls',    -- Go
    'pyright',  -- Python
    'clangd',   -- C/C++
    'lua_ls',   -- Lua
    'rust_analyzer' -- Rust
}

require("mason-lspconfig").setup {
    ensure_installed = servers,
    automatic_installation = true,
}

