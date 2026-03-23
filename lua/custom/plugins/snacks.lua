return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
    picker = {},
  },
  keys = {
    -- Search pickers (replacing Telescope)
    { '<leader>sh', function() Snacks.picker.help() end, desc = '[S]earch [H]elp' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eymaps' },
    { '<leader>sf', function() Snacks.picker.smart() end, desc = '[S]earch [F]iles' },
    { '<leader>ss', function() Snacks.picker.pickers() end, desc = '[S]earch [S]elect Picker' },
    { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch current [W]ord', mode = { 'n', 'v' } },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = '[S]earch by [G]rep' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '[S]earch [D]iagnostics' },
    { '<leader>sr', function() Snacks.picker.resume() end, desc = '[S]earch [R]esume' },
    { '<leader>s.', function() Snacks.picker.recent() end, desc = '[S]earch Recent Files' },
    { '<leader>sc', function() Snacks.picker.commands() end, desc = '[S]earch [C]ommands' },
    { '<leader><leader>', function() Snacks.picker.buffers() end, desc = '[ ] Find existing buffers' },
    { '<leader>/', function() Snacks.picker.lines() end, desc = '[/] Fuzzily search in current buffer' },
    { '<leader>s/', function() Snacks.picker.grep_buffers() end, desc = '[S]earch [/] in Open Files' },
    { '<leader>sn', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = '[S]earch [N]eovim files' },

    -- File explorer
    { '<leader>pe', function() Snacks.explorer() end, desc = 'File Explorer' },

    -- Scratch buffers
    { '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
    { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },

    -- Notifications
    { '<leader>n', function() Snacks.notifier.show_history() end, desc = 'Notification History' },
    { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },

    -- Buffer
    { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },

    -- File operations
    { '<leader>cR', function() Snacks.rename.rename_file() end, desc = 'Rename File' },

    -- Git
    { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git Browse' },
    { '<leader>gb', function() Snacks.git.blame_line() end, desc = 'Git Blame Line' },
    { '<leader>gf', function() Snacks.lazygit.log_file() end, desc = 'Lazygit Current File History' },
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
    { '<leader>gl', function() Snacks.lazygit.log() end, desc = 'Lazygit Log (cwd)' },

    -- Terminal
    { '<c-/>', function() Snacks.terminal() end, desc = 'Toggle Terminal' },
    { '<c-_>', function() Snacks.terminal() end, desc = 'which_key_ignore' },

    -- Word references
    { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' } },
    { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' } },

    -- Neovim News
    {
      '<leader>N',
      desc = 'Neovim News',
      function()
        Snacks.win {
          file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = 'yes',
            statuscolumn = ' ',
            conceallevel = 3,
          },
        }
      end,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
        Snacks.toggle.diagnostics():map '<leader>ud'
        Snacks.toggle.line_number():map '<leader>ul'
        Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
        Snacks.toggle.treesitter():map '<leader>uT'
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
        Snacks.toggle.inlay_hints():map '<leader>uh'
      end,
    })

    -- LSP picker keymaps (replacing Telescope LSP keymaps)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('snacks-lsp-attach', { clear = true }),
      callback = function(event)
        local buf = event.buf
        vim.keymap.set('n', 'grr', function() Snacks.picker.lsp_references() end, { buffer = buf, desc = '[G]oto [R]eferences' })
        vim.keymap.set('n', 'gri', function() Snacks.picker.lsp_implementations() end, { buffer = buf, desc = '[G]oto [I]mplementation' })
        vim.keymap.set('n', 'grd', function() Snacks.picker.lsp_definitions() end, { buffer = buf, desc = '[G]oto [D]efinition' })
        vim.keymap.set('n', 'gO', function() Snacks.picker.lsp_symbols() end, { buffer = buf, desc = 'Open Document Symbols' })
        vim.keymap.set('n', 'gW', function() Snacks.picker.lsp_workspace_symbols() end, { buffer = buf, desc = 'Open Workspace Symbols' })
        vim.keymap.set('n', 'grt', function() Snacks.picker.lsp_type_definitions() end, { buffer = buf, desc = '[G]oto [T]ype Definition' })
      end,
    })
  end,
}
