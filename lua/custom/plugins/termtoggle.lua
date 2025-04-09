return {
  'akinsho/toggleterm.nvim',
  -- branch = 'master',
  cmd = 'ToggleTerm',
  keys = {
    { '<A-i>', ':ToggleTerm direction=float<CR>', { desc = 'Toogle Term' } },
  },
  config = true,
}
