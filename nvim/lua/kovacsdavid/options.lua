-- change leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- print the line number in front of each line
vim.opt.number = true

-- show relative line number in front of each line
vim.opt.relativenumber = true

-- number of spaces to use for (auto)indent step
vim.opt.shiftwidth = 4

-- number of spaces to use for (auto)indent stepnumber of spaces that <Tab> in file uses
vim.opt.tabstop = 4

-- number of spaces that <Tab> uses while editing
vim.opt.softtabstop = 4

-- enable the use of mouse clicks
vim.opt.mouse = ''

-- use spaces when <Tab> is inserted
vim.opt.expandtab = true

-- use 'shiftwidth' when inserting <Tab>
vim.opt.smarttab = true

-- let Vim set the title of the window
vim.opt.title = true

-- ignore case in search patterns
vim.opt.ignorecase = true

-- long lines wrap and continue on the next line
vim.opt.wrap = false

-- minimum nr. of lines above and below cursor
vim.opt.scrolloff = 10

-- min. nr. of columns to left and right of cursor
vim.opt.sidescrolloff = 10

-- use linux clipboard
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

 -- save undo information in a file
vim.opt.undofile = true

-- start with empty screen
vim.opt.shortmess:append({ I = true })

-- secure mode for reading .vimrc in current dir
vim.opt.secure = true

 -- string to use for the Vim window title
vim.opt.titlestring = '%f - nvim'

vim.api.nvim_command('filetype plugin indent on')

-- wrapped line repeats indent
vim.opt.breakindent = true;

-- autoremove trailing white spaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

