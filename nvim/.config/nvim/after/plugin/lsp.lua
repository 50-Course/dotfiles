
-- [[ lsp-config.lua ]] --
--
-- LSP configuration
-- Let's rock and roll, we all we need to setup our language server protocol is:
--      * A completion engine
--      * Completion snippets
--      * LSP Mappings
--      * Formatting engine
--
-- This module only contains LSP-specific configurations and as such, completions
-- and formatting configs are moved to respective modules.


local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()


vim.keymap.set('n', 'fd', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'pd', vim.diagnostic.goto_next)

-- Keybinds to manipulate lsp when attached to a current buffer
local on_attach = function(client, buffr)
    local buff_opts = { noremap = true, silent = true, buffer = buffr }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, buff_opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buff_opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, buff_opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, buff_opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, buff_opts)
    vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition, buff_opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, buff_opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, buff_opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, buff_opts)


    -- format on save
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('LspFormatting', {clear=true}),
        buffer = buffr,
        callback = function()
            vim.lsp.buf.format()
        end
    })
end

-- Setup LSP servers

-- Python
require('lspconfig')['pyright'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetype = {'python'}
}

-- Go
require('lspconfig')['gopls'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        }
    }
}

-- Autoconfigure other servers installed with Mason, add capabilities
-- and attach to buffers
local servers = { 'rust_analyzer', 'tsserver', 'bashls', 'vimls', 'yamlls' }

for _, server in ipairs(servers) do
    lspconfig[server].setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end
