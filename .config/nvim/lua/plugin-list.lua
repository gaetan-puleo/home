local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Git column signs and git blame
    require('plugins/gitsigns-nvim'),

    --Theme
    {
        'folke/tokyonight.nvim',
        config = function () require('plugins/tokyonight-nvim') end
    },
    -- buffer tabs
    require('plugins/bufferline-nvim'),

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


          -- DAP
          'mfussenegger/nvim-dap',
          "jay-babu/mason-nvim-dap.nvim",
          "rcarriga/nvim-dap-ui",
          'mxsdev/nvim-dap-vscode-js',
          {"microsoft/vscode-js-debug", build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out" },

        },
        config = function()
          local map = vim.api.nvim_set_keymap
          local dap = require("dap")

          vim.keymap.set('n', '<leader>do', "<Cmd>lua require('dapui').open() <CR>", { desc = '[D]ebugger [o]pen' })
          vim.keymap.set('n', '<leader>dq', "<Cmd>lua require('dapui').close() <CR>", { desc = '[D]ebugger [q]uit' })
          vim.keymap.set('n', '<leader>dt', "<Cmd>lua require('dapui').toggle() <CR>", { desc = '[D]ebugger [t]oggle' })

          vim.keymap.set('n', '<F5>', require 'dap'.continue)
          vim.keymap.set('n', '<F10>', require 'dap'.step_over)
          vim.keymap.set('n', '<F11>', require 'dap'.step_into)
          vim.keymap.set('n', '<F12>', require 'dap'.step_out)
          vim.keymap.set('n', '<leader>db', require 'dap'.toggle_breakpoint)

          require('plugins/lsp/mason-nvim')
          require("dapui").setup()

          --require("mfussenegger/nvim-dap")
          require("mason-nvim-dap").setup({
            ensure_installed = { 'js' },
            handlers = {}, -- sets up dap in the predefined manner
          })

          require("dap-vscode-js").setup({
            -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
            debugger_path = vim.fn.stdpath('data') .. "/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
            --debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
            adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' }, -- which adapters to register in nvim-dap
            -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
            -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
            -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
          })

          for _, language in ipairs({ "typescript", "javascript", 'javascriptreact', "typescriptreact" }) do
            require("dap").configurations[language] = {
                {
                  type = "pwa-node",
                  request = "launch",
                  name = "Launch file",
                  program = "${file}",
                  cwd = "${workspaceFolder}",
                },
                {
                  type = "pwa-node",
                  request = "attach",
                  name = "Attach",
                  processId = require'dap.utils'.pick_process,
                  cwd = "${workspaceFolder}",
                },
                {
                  type = "pwa-node",
                  request = "launch",
                  name = "Debug Jest Tests",
                  -- trace = true, -- include debugger info
                  runtimeExecutable = "node",
                  runtimeArgs = {
                    "./node_modules/jest/bin/jest.js",
                    "--runInBand",
                  },
                  rootPath = "${workspaceFolder}",
                  cwd = "${workspaceFolder}",
                  console = "integratedTerminal",
                  internalConsoleOptions = "neverOpen",
                },
                {
                  type = "pwa-chrome",
                  request = "launch",
                  name = "Start Chrome with \"localhost\"",
                  url = "http://localhost:3000",
                  webRoot = "${workspaceFolder}",
                  userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
                }

            }
          end

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

    {'christoomey/vim-tmux-navigator', config = function() require('plugins/vim-tmux-navigator') end},


    -- keyboard mapping
    require("plugins/which-key"),
    require("plugins/nvim-lightbulb"),

    -- Search and replace
    require('plugins/nvim-spectre'),



    -- git diff manager
    -- { 'sindrets/diffview.nvim', dependencies = {'nvim-lua/plenary.nvim'} }
    })
