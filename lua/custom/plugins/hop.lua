return {
  'phaazon/hop.nvim',
  cmd = 'HopWord',
  keys = {
    { 'fw', ':HopWord<CR>', { desc = '[F]ind [W]ord' } },
  },
  init = function()
    require('hop').setup()
  end,
}
