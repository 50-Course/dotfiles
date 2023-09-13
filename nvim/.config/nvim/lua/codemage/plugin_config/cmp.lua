-- [[ Completions and snippets ]]
-- ===================================
--

local cmp = require('cmp')

require('luasnip.loaders.from_vscode').lazy_load()



cmp.setup({
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
    }, {
        { name = 'path' },
    }),
    mapping = {
        -- select prev item
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        -- select next item
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Scroll the docs downward
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        -- Scroll the docs upward
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- C-y to accept completion
        ['<C-Space>'] = cmp.mapping.complete(),
        -- C-e to cancel completion
        ['<C-x>'] = cmp.mapping.close(),
        ['<C-y>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif require('luasnip').expand_or_jumpable() then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif require('luasnip').jumpable(-1) then
                vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
            else
                fallback()
            end
        end,
    },
    snippet = {
        expand = function(args)
            -- luasnip
            require('luasnip').lsp_expand(args.body)
        end,
    },
})
