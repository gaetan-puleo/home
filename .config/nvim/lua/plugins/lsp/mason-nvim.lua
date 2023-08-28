vim.diagnostic.config({ virtual_text = false })

local wk = require("which-key")
-- local null_ls = require 'null-ls'
-- null_ls.setup({
--   on_attach = function(client, bufnr)
--     if client.supports_method("textDocument/formatting") then
--         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--         vim.api.nvim_create_autocmd("BufWritePre", {
--             group = augroup,
--             buffer = bufnr,
--             callback = function()
--               vim.lsp.buf.format({
--                 bufnr = bufnr,
--                 filter = function(client)
--                   return client.name == "null-ls"
--                 end
--                 })
--             end,
--         })
--     end
--   end
-- })

require("mason").setup()
-- require("mason-null-ls").setup({
--     automatic_setup = true,
--     ensure_installed = {
--       "eslint_d",
--       "prettier",
--         -- Opt to list sources here, when available in mason.
--     },
--     handlers = {

--     },
-- })
require("mason-lspconfig").setup({
  ensure_installed = {
    "cssls", -- css
    "cssmodules_ls", -- css module
    "html",
    "jsonls",
    "vtsls", -- JS , TS
    "tailwindcss",
    "dockerls",
    "astro", -- astro templates
  },
})

require('mason-tool-installer').setup {
  ensure_installed = {
    'prettier'
  }
}
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup {}
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  -- ["rust_analyzer"] = function ()
  --     require("rust-tools").setup {}
  -- end
}


vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    local g_mapping = {
      d = { desc = "Go to definition"},
      D = { desc = "Go to declaration"},
      i = { desc = "List all the implementations"},
      t = { desc = "Go to type definition"},
      r = { desc = "List all the references"},
      -- s = { desc = "Show current signature information"},
      -- l = { desc = "Show Diagnostics popup"},
      R = { desc = "Rename symbol"},
    }

    wk.register(g_mapping, {buffer = bufnr, prefix = "g"})

    local leader_mapping = {
      l = {
        name = "lsp",
        r = 'Rename Current Symbol',
        a = 'Show current action',
        s = { desc = "Show current signature information"},
        d = { desc = "Show Diagnostics popup"},

      },
    }

    wk.register(leader_mapping, {buffer = bufnr, prefix = "<leader>"})
    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<leader>la', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', '<leader>ld', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})
