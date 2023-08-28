local map = vim.keymap.set


-- Set true colors
vim.o.termguicolors = true

-- show previous file
map({'n'}, '<leader><leader>', ':e# <CR>', {noremap = true, silent = true})

-- clear highlight
map({ 'n', 'v' }, '<Space>', '<Nop>', { noremap = true, silent = true })

-- source init lua
map({ 'n', 'v' }, '<C-r>', '<Cmd>luafile ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })

-- go to the left
--map({ 'n', 'v' }, '<M-h>', '<C-w>h', { noremap = true, silent = true })

-- go to the right
--map({ 'n', 'v' }, '<M-l>', '<C-w>l', { noremap = true, silent = true })

-- go to the top
--map({ 'n', 'v' }, '<M-k>', '<C-w>k', { noremap = true, silent = true })

-- go to the bottom
-- map({ 'n', 'v' }, '<M-j>', '<C-w>j', { noremap = true, silent = true })

-- move cursor to 1 line to the top
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- move cursor to 1 line to the bottom
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

