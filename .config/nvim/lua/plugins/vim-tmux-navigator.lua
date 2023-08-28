local map = vim.keymap.set
vim.g.tmux_navigator_no_mappings = 1

map({'n'}, '<M-h>', ':<C-U>TmuxNavigateLeft<cr>', {noremap = true, silent = true})
map({'n'}, '<M-l>', ':<C-U>TmuxNavigateRight<cr>', {noremap = true, silent = true})
map({'n'}, '<M-k>', ':<C-U>TmuxNavigateUp<cr>', {noremap = true, silent = true})
map({'n'}, '<M-j>', ':<C-U>TmuxNavigateDown<cr>', {noremap = true, silent = true})
