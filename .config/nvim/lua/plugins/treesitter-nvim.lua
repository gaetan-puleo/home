
vim.opt.runtimepath:append("$HOME/.local/share/treesitter")

require'nvim-treesitter.configs'.setup {
  parser_install_dir = "$HOME/.local/share/treesitter",
  ensure_installed = {"typescript"} ,
  -- sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  autotag = {
		enable = true
	},
	context_commentstring = {
		enable = true,
		-- config = {
		-- 	javascript = {
		-- 		__default = '// %s',
		-- 		jsx_element = '{/* %s */}',
		-- 		jsx_fragment = '{/* %s */}',
		-- 		jsx_attribute = '// %s',
		-- 		comment = '// %s'
		-- 	}
		-- }
  },
	refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
  },
	highlight = {
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    enable = true,
    use_languagetree = true,
    --additional_vim_regex_highlighting = true,
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}
