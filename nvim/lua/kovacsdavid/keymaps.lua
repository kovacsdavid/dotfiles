local wk = require('which-key');

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc='Find Files'})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc='Live Grep'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc='Buffers'})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc='Help Tags'})


wk.add({
    {"<leader>f", group = "Find"}
})

-- own keys
vim.keymap.set('n', '<leader>bl', '<cmd>buffers<cr>', {desc='List Buffers'})
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>', {desc='Next Buffer'})
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<cr>', {desc='Previous Buffer'})

wk.add({
    {"<leader>b", group = "Buffer"}
})

vim.keymap.set('n', '0', '^', {desc='Remap VIM 0 to first non-blank character'}) 


vim.keymap.set('n', '<M-1>', vim.cmd.Ex, {desc='File Explorer'})

-- remap split switches
vim.keymap.set('n', '<C-j>', '<C-W>j', {desc='Jump to bottom split'})
vim.keymap.set('n', '<C-k>', '<C-W>k', {desc='Jump to top split'})
vim.keymap.set('n', '<C-h>', '<C-W>h', {desc='Jump to left split'})
vim.keymap.set('n', '<C-l>', '<C-W>l', {desc='Jump to right split'})

-- tabs keymaps
vim.keymap.set('n', '<leader>tn', builtin.find_files, {desc='New tab'})
vim.keymap.set('n', '<leader>tc', builtin.find_files, {desc='Close tab'})
vim.keymap.set('n', '<leader>tt', builtin.find_files, {desc='Next tab'})

wk.add({
    {"<leader>t", group = "Tabs"}
})

