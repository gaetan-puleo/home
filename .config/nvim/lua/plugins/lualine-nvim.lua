return {
  'nvim-lualine/lualine.nvim',
  config = function ()

    function space ()
      return "⠀"
    end

    local colors = {
      black         = '#111111',
      white         = '#ffffff',
      red           = '#f7768e',
      green         = '#9ece6a',
      blue          = '#7aa2f7',
      yellow        = '#e0af68',
      purple        = '#bb9af7',
      darkgray      = '#1a1b26',
      gray          = '#16161e',
      lightgray     = '#504945',
      inactivegray  = '#7c6f64',
    }

    local l = {
      normal = {
        a = {bg = colors.blue, fg = colors.gray, gui = 'bold'},
        b = {bg = colors.gray, fg = colors.white},
        c = {bg = colors.gray, fg = colors.white}
      },
      insert = {
        a = {bg = colors.green, fg = colors.gray, gui = 'bold'},
        b = {bg = colors.gray, fg = colors.white},
        c = {bg = colors.gray, fg = colors.white}
      },
      visual = {
        a = {bg = colors.purple, fg = colors.gray, gui = 'bold'},
        b = {bg = colors.gray, fg = colors.white},
        c = {bg = colors.gray, fg = colors.white}
      },
      replace = {
        a = {bg = colors.red, fg = colors.gray, gui = 'bold'},
        b = {bg = colors.gray, fg = colors.white},
        c = {bg = colors.gray, fg = colors.white}
      },
      command = {
        a = {bg = colors.yellow, fg = colors.gray, gui = 'bold'},
        b = {bg = colors.gray, fg = colors.white},
        c = {bg = colors.gray, fg = colors.white}
      },
      inactive = {
        a = {bg = colors.darkgray, fg = colors.gray, gui = 'bold'},
        b = {bg = colors.gray, fg = colors.darkgray},
        c = {bg = colors.gray, fg = colors.darkgray}
      }
    }

    require('lualine').setup {
      -- ... your lualine config
      options = {
        --theme = l,
        globalstatus = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {'NvimTree'},
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {{'filetype', icon_only = true},

          {
            'filename',
            path = 1,
            shorting_target = 5,
            file_status = true, -- displays file status (readonly status, modified status)

          }
        },
        lualine_c = {'branch', 'diff'},
        lualine_x = { 'diagnostics','encoding', 'fileformat','filetype'},
        lualine_y = {},
        lualine_z = {'location'}
      },

      -- winbar = { lualine_a = {'filename'}},
      -- inactive_winbar = { lualine_a = {'filename'}}
      -- ... your lualine config
    }
  end
}
