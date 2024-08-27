return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    -- Enable theme
    vim.cmd("colorscheme tokyonight-night")
  end
}
