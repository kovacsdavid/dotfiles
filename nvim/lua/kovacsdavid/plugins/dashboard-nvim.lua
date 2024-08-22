return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup({
      theme = 'doom',
      config = {
        header = {
          '',
          '',
          '',
          'KKKKKKKKK    KKKKKKKDDDDDDDDDDDDD',
          'K:::::::K    K:::::KD::::::::::::DDD',
          'K:::::::K    K:::::KD:::::::::::::::DD',
          'K:::::::K   K::::::KDDD:::::DDDDD:::::D',
          'KK::::::K  K:::::KKK  D:::::D    D:::::D',
          '  K:::::K K:::::K     D:::::D     DD',
          '  K::::::K:::::K      D:::::D     DD',
          '  K:::::::::::K       D:::::D     DD',
          '  K:::::::::::K       D:::::D     DD',
          '  K::::::K:::::K      D:::::D     DD',
          '  K:::::K K:::::K     D:::::D     DD',
          'KK::::::K  K:::::KKK  D:::::D    D:::::D',
          'K:::::::K   K::::::KDDD:::::DDDDD:::::D',
          'K:::::::K    K:::::KD:::::::::::::::DD',
          'K:::::::K    K:::::KD::::::::::::DDD',
          'KKKKKKKKK    KKKKKKKDDDDDDDDDDDDD',
          '',
          '',
          '',
        },
        center = {
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = ' Find File',
            desc_hl = 'String',
            key = 'f',
            keymap = '<leader>ff',
            key_hl = 'Number',
            key_format = ' %s', -- remove default surrounding `[]`
            action = 'Telescope find_files'
          },
          {
            icon = ' ',
            desc = ' Find Text',
            key = 'g',
            keymap = '<leader>ff',
            key_format = ' %s', -- remove default surrounding `[]`
            action = 'Telescope live_grep'
          },
        },
        footer = {}  --your footer
      }
    })
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}
