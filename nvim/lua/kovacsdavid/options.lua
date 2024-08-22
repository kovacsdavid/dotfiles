-- change leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true -- print the line number in front of each line
vim.opt.relativenumber = true -- show relative line number in front of each line
vim.opt.shiftwidth = 4 -- number of spaces to use for (auto)indent step
vim.opt.tabstop = 4 -- number of spaces to use for (auto)indent stepnumber of spaces that <Tab> in file uses
vim.opt.softtabstop = 4 -- number of spaces that <Tab> uses while editing
vim.opt.mouse = '' -- enable the use of mouse clicks
vim.opt.expandtab = true -- use spaces when <Tab> is inserted
vim.opt.smarttab = true -- use 'shiftwidth' when inserting <Tab>
vim.opt.title = true -- let Vim set the title of the window
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.wrap = false -- long lines wrap and continue on the next line
vim.opt.scrolloff = 8 -- minimum nr. of lines above and below cursor
vim.opt.sidescrolloff = 8 -- min. nr. of columns to left and right of cursor
vim.opt.clipboard = 'unnamedplus' -- use linux clipboard
vim.opt.undofile = true -- save undo information in a file
vim.opt.shortmess:append({ I = true }) -- start with empty screen
vim.opt.secure = true -- secure mode for reading .vimrc in current dir
vim.opt.titlestring = '%f - nvim' -- string to use for the Vim window title
vim.api.nvim_command('filetype plugin indent on')
vim.opt.breakindent = true; -- wrapped line repeats indent
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
}) -- autoremove trailing white spaces
