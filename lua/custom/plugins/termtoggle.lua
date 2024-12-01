return {
  'akinsho/toggleterm.nvim',
  -- branch = 'master',
  cmd = 'ToggleTerm',
  keys = {
    { '<A-i>', ':ToggleTerm direction=horizontal<CR>', { desc = 'Toogle Term' } },
  },
  config = true,
}
