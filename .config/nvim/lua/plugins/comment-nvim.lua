

return {
  'terrortylor/nvim-comment',
  config = function ()
    local map = vim.api.nvim_set_keymap

    require('nvim_comment').setup({
      comment_empty = false,
      create_mappings = true,
    })

    vim.api.nvim_set_keymap('n', '<M-/>', ':CommentToggle<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('v', '<M-/>', ":'<,'>CommentToggle<CR>", {noremap = true, silent = true})

    -- used for azerty keyboard (need to be removed when)
    vim.api.nvim_set_keymap('n', '<C-/>', ':CommentToggle<CR>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('v', '<C-/>', ":'<,'>CommentToggle<CR>", {noremap = true, silent = true})
  end
}
