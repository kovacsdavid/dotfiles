local vim_options = vim.fn.stdpath('config') .. '/options.vim'
vim.cmd.source(vim_options)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '

-- [[ Setting options ]] See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:help option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

-- Print the line number in front of each line
vim.o.number = true

-- Use relative line numbers, so that it is easier to jump with j, k. This will affect the 'number'
-- option above, see `:h number_relativenumber`
vim.o.relativenumber = true

-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight the line where the cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Show <tab> and trailing spaces
vim.o.list = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s) See `:help 'confirm'`
vim.o.confirm = true

-- disable soft wrap
vim.opt.wrap = false

-- [[ Basic Autocommands ]].
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Create user commands ]]
-- See `:h nvim_create_user_command()` and `:h user-commands`

-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.fn.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }))
end, { desc = 'Print the git blame for the current line' })

-- [[ Add optional packages ]]
-- Nvim comes bundled with a set of packages that are not enabled by
-- default. You can enable any of them by using the `:packadd` command.

-- For example, to add the "nohlsearch" package to automatically turn off search highlighting after
-- 'updatetime' and when going to insert mode
vim.cmd('packadd! nohlsearch')

vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
      config = function()
        -- Enable theme
        vim.cmd("colorscheme tokyonight-night")
      end
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        -- start lualine with default config
        require('lualine').setup({})
      end
    },
    { 'tpope/vim-sleuth' },
    {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('telescope').setup({
          defaults = {
            vimgrep_arguments = {
              'rg',
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
              '--smart-case',
              '--hidden',

              -- Exclude some patterns from search
              "--glob=!**/.git/*",
              "--glob=!**/.idea/*",
              "--glob=!**/.vscode/*",
              "--glob=!**/build/*",
              "--glob=!**/dist/*",
              "--glob=!**/yarn.lock",
              "--glob=!**/package-lock.json",
            },
          },
          pickers = {
            find_files = {
              theme = "dropdown",
              hidden = true,
              find_command = {
                "rg",
                "--files",
                "--hidden",
                "--glob=!**/.git/*",
                "--glob=!**/.idea/*",
                "--glob=!**/.vscode/*",
                "--glob=!**/build/*",
                "--glob=!**/dist/*",
                "--glob=!**/yarn.lock",
                "--glob=!**/package-lock.json",
              },
            },
            live_grep = {
              theme = "dropdown",
            },
            buffers = {
              theme = "dropdown",
            },
            help_tags = {
              theme = "dropdown",
            },
            treesitter = {
              theme = "dropdown",
            },
            lsp_workspace_symbols = {
              theme = "dropdown",
            },
          },
        })
      end
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {},
    },
    {"lewis6991/gitsigns.nvim"},
    {
      "folke/trouble.nvim",
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
    },
    {
      "github/copilot.vim"
    },
    {
      "CopilotC-Nvim/CopilotChat.nvim",
      dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
      },
      opts = {
        {
          model = 'gpt-4.1',           -- AI model to use
          temperature = 0.1,           -- Lower = focused, higher = creative
          window = {
            layout = 'vertical',       -- 'vertical', 'horizontal', 'float'
            width = 0.5,              -- 50% of screen width
          },
          auto_insert_mode = true,     -- Enter insert mode when opening
        }
      },
    },
    {
      "mbbill/undotree"
    },
    {
      "tpope/vim-fugitive"
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },

      config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
          "force",
          {},
          vim.lsp.protocol.make_client_capabilities(),
          cmp_lsp.default_capabilities())

        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "lua_ls",
            "rust_analyzer",
            "ts_ls",
          },
          handlers = {
            function(server_name) -- default handler (optional)

              require("lspconfig")[server_name].setup {
                capabilities = capabilities
              }
            end,

            ["lua_ls"] = function()
              local lspconfig = require("lspconfig")
              lspconfig.lua_ls.setup {
                capabilities = capabilities,
                settings = {
                  Lua = {
                    diagnostics = {
                      globals = { "vim", "it", "describe", "before_each", "after_each" },
                    }
                  }
                }
              }
            end,
          }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' }, -- For luasnip users.
          }, {
              { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
          -- update_in_insert = true,
          float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
          },
        })
      end
    },
    {
      'stevearc/conform.nvim',
      opts = {},
    },
    {
      "chentoast/marks.nvim",
      event = "VeryLazy",
      opts = {},
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    javascript = { "prettierd", "prettier", stop_after_first = true },
  },
})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "rust", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "typescript", "javascript", "html", "sql", "go" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,
  ---
  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = { enable = true },

  indent = { enable = true},
}

require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}

vim.lsp.config('rust_analyzer', {
  filetypes = { "rust" },
  cmd = { "rust-analyzer" },
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true;
      }
    }
  },
})

vim.lsp.config('ts_ls', {
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
})


vim.lsp.enable('rust_analyzer')
vim.lsp.enable('ts_ls')

vim.opt.splitright = true

-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

vim.keymap.set('n', '0', '^', {desc='Remap VIM 0 to first non-blank character'})
vim.keymap.set('v', '0', '^', {desc='Remap VIM 0 to first non-blank character'})
vim.keymap.set('n', '<C-n>', '<cmd>:noh<cr>', {desc='Remove search highlight'})

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Diagnostic keymap
vim.keymap.set('n', '<leader>df', '<cmd>lua vim.diagnostic.open_float()<cr>', {desc='[D]iagnostic [F]loat'})
vim.keymap.set('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<cr>', {desc='[D]iagnostic [N]ext'})
vim.keymap.set('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<cr>', {desc='[D]iagnostic [P]revious'})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>ft', builtin.treesitter, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fs', builtin.lsp_workspace_symbols, { desc = 'Lists LSP document symbols in the current buffer' })

vim.keymap.set('n', '<leader>bl', '<cmd>buffers<cr>', {desc='[B]uffer [L]ist'})
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>', {desc='[B]uffer [N]ext'})
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<cr>', {desc='[B]uffer [P]revious'})

vim.keymap.set('n', '<leader>sb', '<cmd>set scb!<cr>', {desc='Toggle [S]croll[b]ind'})

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, {desc='[U]ndotreeToggle'})

vim.keymap.set('n', '<leader>g', '<cmd>Git<cr>', {desc='[G]it'})
