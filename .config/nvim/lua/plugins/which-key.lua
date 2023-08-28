return {

  "folke/which-key.nvim",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    local wk = require("which-key")
    require("which-key").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    })

    local leader_groups = {
      d = { name = 'debugger' },
      g = { name = 'git'},
      b = { name = 'buffers'},
      f = { name = 'files'},
      s = { name = 'search'},
      ['<space>'] = "which_key_ignore"
    }

    wk.register(leader_groups, {buffer = bufnr, prefix = "<leader>"})
  end,
}
