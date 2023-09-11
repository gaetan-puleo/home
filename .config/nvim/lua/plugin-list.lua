local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Git column signs and git blame
    require('plugins/gitsigns-nvim'),

    -- --Theme
    -- {
    --     'folke/tokyonight.nvim',
    --     config = function () require('plugins/tokyonight-nvim') end
    -- },

    -- Theme
    { "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function ()
      vim.cmd.colorscheme 'catppuccin'


      require("catppuccin").setup({
        term_colors = true,
        transparent_background = false,
        styles = {
          comments = {},
          conditionals = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
        },

          flavour = "mocha", -- latte, frappe, macchiato, mocha
        })
        -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
      end
    },
    -- {
    --     'aktersnurra/no-clown-fiesta.nvim',
    --     config = function ()

    --     vim.cmd[[colorscheme no-clown-fiesta]]
    --       require("no-clown-fiesta").setup({
    --         transparent = false, -- Enable this to disable the bg color
    --         styles = {
    --           -- You can set any of the style values specified for `:h nvim_set_hl`
    --           comments = {},
    --           keywords = {},
    --           functions = {},
    --           variables = {},
    --           type = { bold = true },
    --           lsp = { underline = true }
    --         },
    --       })
    --     end
    -- },


    -- buffer tabs
    -- require('plugins/bufferline-nvim'),

    { 'echasnovski/mini.nvim', version = '*',
      config = function() require('mini.tabline').setup() end
    },


    { 'nocksock/do.nvim',
      config = function()
        require('do').setup({
          winbar = true
        })
      end
    },


    -- dashboard
    require('plugins/mini-starter'),

    -- scroll
    require('plugins/nvim-scrollbar'),

    -- Search
    require('plugins/nvim-hlslens'),

    -- Color proview
    require('plugins/nvim-colorizer'),

    -- Dropbar
    -- { 'Bekaboo/dropbar.nvim' }, (wait for nvim 0.10)

    -- {
    --   'kvrohit/rasmus.nvim',
    --   config = function ()

    --   -- Configure the appearance
    --   vim.g.rasmus_italic_functions = true
    --   vim.g.rasmus_bold_functions = true

    --   -- Set the colorscheme variant to monochrome
    --   vim.g.rasmus_variant = "dark"
    --     vim.cmd [[colorscheme rasmus]]
    --   end
    -- },

    -- {
    --   'mcchrish/zenbones.nvim',
    --   dependencies = "rktjmp/lush.nvim",
    --   config = function ()
    --     vim.cmd [[colorscheme rosebones]]
    --   end
    -- },
    -- {
    --   'rktjmp/lush.nvim'
    -- },

    -- Status
    require('plugins/lualine-nvim'),
    -- indent line
    { 'echasnovski/mini.indentscope', version = '*', config = function ()  require('mini.indentscope').setup() end },

    -- treesitter a better syntax parser
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
            'windwp/nvim-ts-autotag',
            'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/playground'
        },
        config = function() require('plugins/treesitter-nvim') end,
    },

    -- Tree file manager
    {
        "nvim-neo-tree/neo-tree.nvim",
        config = function() require('plugins/neo-tree-nvim') end,
        branch = "v2.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
          {
            's1n7ax/nvim-window-picker',
            tag = 'v1.5',
            config = function()
              require'window-picker'.setup()
            end,
          },
        }
    },

    -- Lsp config and installer
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        dependencies = {
          "williamboman/mason-lspconfig.nvim",
          "neovim/nvim-lspconfig",
          'WhoIsSethDaniel/mason-tool-installer.nvim',
        },
        config = function()
          require('plugins/lsp/mason-nvim')

        end
    },

    require('plugins/nvim-lint'),
    require('plugins/formatter-nvim'),
    -- {
    --   "jay-babu/mason-null-ls.nvim",
    --   event = { "BufReadPre", "BufNewFile" },
    --   dependencies = {
    --     "williamboman/mason.nvim",
    --     "jose-elias-alvarez/null-ls.nvim",
    --   },
    -- },

    -- Completion module
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp-signature-help',

        -- For luasnip users.
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        -- github copilot alternative
        "jcdickinson/codeium.nvim",


      },
      commit = '6c84bc75c64f778e9f1dcb798ed41c7fcb93b639',
      config = function() require('plugins/nvim-cmp') end
    },

    -- debugger
    {
    },


    -- Snippets
    {"rafamadriz/friendly-snippets", config = function() require('luasnip.loaders.from_vscode').lazy_load() end, },

    -- Comment
    require('plugins/comment-nvim'),

    -- Improve UI
    {'stevearc/dressing.nvim'},

    -- General pickeer tool
    {'nvim-telescope/telescope.nvim', tag = '0.1.1', dependencies = {'nvim-lua/plenary.nvim'}, config = function() require('plugins/telescope-nvim') end},

    -- {'christoomey/vim-tmux-navigator', config = function() require('plugins/vim-tmux-navigator') end},

    { "alexghergh/nvim-tmux-navigation",  config = function()

        local nvim_tmux_nav = require('nvim-tmux-navigation')

        nvim_tmux_nav.setup {
            disable_when_zoomed = true -- defaults to false
        }

        vim.keymap.set('n', "<M-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
        vim.keymap.set('n', "<M-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
        vim.keymap.set('n', "<M-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
        vim.keymap.set('n', "<M-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
        -- vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
        -- vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

    end },


    -- keyboard mapping
    require("plugins/which-key"),
    require("plugins/nvim-lightbulb"),

    -- Search and replace
    require('plugins/nvim-spectre'),



    -- git diff manager
    -- { 'sindrets/diffview.nvim', dependencies = {'nvim-lua/plenary.nvim'} }
    })
