return {
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-cmdline',
  },
  config = function()
    local cmp = require('cmp')

    cmp.setup({
        sources = {
            {name = 'nvim_lsp'},
            {name = 'buffer'},
            {name = 'path'},
            {name = 'luasnip'},
        },
        snippet = {
            expand = function(args)
                -- You need Neovim v0.10 to use vim.snippet
                vim.snippet.expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({}),
    })
  end
}
