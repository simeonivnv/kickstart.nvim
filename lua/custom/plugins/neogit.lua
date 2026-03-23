return {
  'NeogitOrg/neogit',
  cmd = 'Neogit',
  keys = {
    { '<leader>gn', ':Neogit<CR>', { desc = 'Neogit reveal' } },
  },
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration
    'folke/snacks.nvim',
  },
  config = true,
}
