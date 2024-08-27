return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v4.x',
  dependencies = {
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
        -- lsp-zero
    local lsp_zero = require('lsp-zero')

    -- lsp_attach is where you enable features that only work
    -- if there is a language server active in the file
    local lsp_attach = function(client, bufnr)
        local opts = {buffer = bufnr}

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end

    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = capabilities,
    })

    local home = os.getenv("HOME")

    require('lspconfig').tsserver.setup({
        capabilities = capabilities,
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = home .. "/.nvm/versions/node/v22.6.0/lib/node_modules/@vue/typescript-plugin",
            languages = {"javascript", "typescript", "vue"},
          },
        },
      },
      filetypes = {
        "javascript",
        "typescript",
        "vue",
      },
    })
    require('lspconfig').phpactor.setup({
        capabilities = capabilities,
    })
    require('lspconfig').volar.setup({
        capabilities = capabilities,
        filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
        init_options = {
            vue = {
                -- hybridMode = false,
                hybridMode = true,
            },
            typescript = {
                tsdk = home .. "/.nvm/versions/node/v22.6.0/lib/node_modules/typescript/lib",
            },
        },
    })
    require('lspconfig').eslint.setup({
        capabilities = capabilities,
    })

  end
}

