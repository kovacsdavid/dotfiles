return {
  'voldikss/vim-floaterm',
  keys = {
    { '<F8>', '<cmd>FloatermToggle<CR>' },
    { '<F8>', '<Esc><cmd)FloatermToggle<CR>', mode = 'i' },
    { '<F8>', '<C-\\><C-n><cmd>FloatermToggle<CR>', mode = 't' },
  },
  cmd = { 'FloatermToggle' },
  init = function()
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
  end,
}
