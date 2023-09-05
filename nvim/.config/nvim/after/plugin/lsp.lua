
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
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, buff_opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, buff_opts)
    vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition, buff_opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, buff_opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, buff_opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, buff_opts)


    -- format on save
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('LspFormatting', {clear=true}),
        buffer = buffr,
        callback = function()
            print('Formatting...')
            vim.lsp.buf.format()
            print('Formatting Completed')
        end
    })
end



