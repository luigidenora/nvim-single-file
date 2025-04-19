return {
  'hrsh7th/nvim-cmp',
  config = function()
    local cmp = require('cmp')
    cmp.setup({
      sources = {
        { name = 'nvim_lsp' },
      },
      mapping = cmp.mapping.preset.insert({
        -- Enter key confirms completion item
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Ctrl + space triggers completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end, { 'i', 's' }),

        -- Shift-Tab to go backwards
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
    })
  end
}
