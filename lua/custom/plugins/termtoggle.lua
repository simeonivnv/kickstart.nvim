return {
  'akinsho/toggleterm.nvim',
  -- branch = 'master',
  enabled = false,
  cmd = 'ToggleTerm',
  keys = {
    { '<A-i>', ':ToggleTerm direction=float<CR>', { desc = 'Toogle Term' } },
  },
  config = true,
}
