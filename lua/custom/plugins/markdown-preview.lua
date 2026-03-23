return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && npm install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
    vim.g.mkdp_open_to_the_world = 1
    vim.g.mkdp_echo_preview_url = 1
    vim.g.mkdp_port = 5480
  end,
  ft = { 'markdown' },
}
