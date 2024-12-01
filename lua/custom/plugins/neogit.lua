return {
  'NeogitOrg/neogit',
  cmd = 'Neogit',
  keys = {
    { '<leader>gn', ':Neogit<CR>', { desc = 'Neogit reveal' } },
  },
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration

    -- Only one of these is needed, not both.
    'nvim-telescope/telescope.nvim', -- optional
  },
  config = true,
}
