local builtin = require('telescope.builtin')

local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ['<C-j>'] = actions.preview_scrolling_down;
        ['<C-k>'] = actions.preview_scrolling_up,

      },
    },
  },
  pickers = {
    find_files = {
      sorting_strategy = 'ascending',
      prompt_title = false,
      previewer = false,
      hidden = true,  -- include hidden files
      ignore = true,  -- include ignored files
      layout_strategy = 'vertical',
      layout_config = {
        vertical = {
          anchor = "N", -- pin to top (N like nord)
          height = 0.5, -- 0.1 equal 10%
          prompt_position = "top",
          width = 0.7 -- 0.1 equal 10%
        },
      },
    }
  },
}

vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = '[F]ind [F]iles'})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = '[F]ind with [G]rep'})
vim.keymap.set('n', '<leader>?', builtin.keymaps, {desc = 'Show keymaps'})

vim.keymap.set('n', '<leader>gh', builtin.git_commits, {desc = 'Show [g]it [h]istory '})
vim.keymap.set('n', '<leader>gb', builtin.git_branches, {desc = 'Select [g]it [b]ranches'})

-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>bl', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

