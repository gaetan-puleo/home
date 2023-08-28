-- source : https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options ]]
-- See `:help vim.o`

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- reduce cursorhold to 100
vim.g.cursorhold_updatetime = 100

-- enable local .nvimrc
vim.o.exrc = true
vim.o.secure = true

-- one tab is equal 2 spaces
-- to customize the spacing locally, create an .editorconfig file for your project
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2

vim.o.belloff = 'all' -- disable alerts

vim.o.splitbelow = true -- Horizontal splits will automatically be below
vim.o.splitright = true -- Vertical splits will automatically be to the right

vim.wo.cursorline = true -- Enable highlighting of the current line

vim.o.backup = false -- Disable backup
vim.o.swapfile = false -- Disable swapfile

vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.o.autowrite = true -- Autosave when changing buffer

vim.o.hidden = true -- Required to keep multiple buffers open

vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore

vim.wo.numberwidth = 4 -- columns number in gutter
vim.o.cmdheight = 2 -- cmd line height

--Set highlight on search
vim.o.hlsearch = true
vim.o.incsearch = true

--Incremental live completion
vim.o.inccommand = "nosplit"

vim.opt.listchars = {eol = '↵',trail = '~',tab = '>-', nbsp = '␣', space = "_"}
