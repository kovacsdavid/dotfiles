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


vim.keymap.set('n', '<M-1>', vim.cmd.Ex, {desc='File Explorer'})
