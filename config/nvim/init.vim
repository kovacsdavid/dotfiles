:let mapleader = ","

nnoremap <leader>n <cmd>Telescope find_files<cr>
nnoremap <leader>f <cmd>Telescope live_grep<cr>

set number

lua require('plugins')
