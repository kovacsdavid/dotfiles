local wk = require('which-key');

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc='[F]ind [F]iles'})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc='[F]ind [G]rep'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc='[F]ind [B]uffer'})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc='[F]ind [H]elp'})


wk.add({
    {"<leader>f", group = "[F]ind"}
})

-- own keys
vim.keymap.set('n', '<leader>bl', '<cmd>buffers<cr>', {desc='[B]uffer [L]ist'})
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>', {desc='[B]uffer [N]ext'})
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<cr>', {desc='[B]uffer [P]revious'})

wk.add({
    {"<leader>b", group = "[B]uffer"}
})

vim.keymap.set('n', '0', '^', {desc='Remap VIM 0 to first non-blank character'})
vim.keymap.set('v', '0', '^', {desc='Remap VIM 0 to first non-blank character'})
vim.keymap.set('n', '<C-s>', '<cmd>w<cr>', {desc='Save file'})
vim.keymap.set('n', '<C-a>', 'ggVG', {desc='Select all'})
vim.keymap.set('n', '<C-n>', '<cmd>:noh<cr>', {desc='Remove search highlight'})

vim.keymap.set('n', '<M-1>', '<cmd>Neotree<cr>', {desc='File Explorer'})

-- remap split switches
vim.keymap.set('n', '<C-j>', '<C-W>j', {desc='Jump to bottom split'})
vim.keymap.set('n', '<C-k>', '<C-W>k', {desc='Jump to top split'})
vim.keymap.set('n', '<C-h>', '<C-W>h', {desc='Jump to left split'})
vim.keymap.set('n', '<C-l>', '<C-W>l', {desc='Jump to right split'})

-- tabs keymaps
vim.keymap.set('n', '<leader>tt', '<cmd>tabnew<cr>', {desc='[T]ab New'})
vim.keymap.set('n', '<leader>tc', '<cmd>tabclose<cr>', {desc='[T]ab [C]lose'})
vim.keymap.set('n', '<leader>tn', '<cmd>tabnext<cr>', {desc='[T]ab [N]ext'})
vim.keymap.set('n', '<leader>tp', '<cmd>tabprevious<cr>', {desc='[T]ab [P]revious'})

wk.add({
    {"<leader>t", group = "[T]abs"}
})

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

