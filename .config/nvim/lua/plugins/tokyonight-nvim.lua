-- init.lua
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_dark_float = true
-- vim.g.tokyonight_dark_sidebar = true
-- vim.g.tokyonight_terminal_colors = true
-- vim.g.tokyonight_sidebars = { "quickfix", "__vista__", "terminal", "Outline", "packer", "spectre_panel", "Trouble", "fern" }
-- vim.g.tokyonight_hide_inactive_statusline = false
-- vim.cmd("hi! SniprunVirtualTextOk ctermbg=Cyan guibg=#66eeff ctermfg=Black guifg=#000000")

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }


require("tokyonight").setup({
  transparent = false,
  style = 'night',

  on_highlights = function(hl, c)
    local prompt = "#2d3149"
    hl.TelescopeNormal = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopePromptNormal = {
      bg = prompt,
    }
    hl.TelescopePromptBorder = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePromptTitle = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePreviewTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopeResultsTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
  end,
})


vim.cmd[[colorscheme tokyonight]]
