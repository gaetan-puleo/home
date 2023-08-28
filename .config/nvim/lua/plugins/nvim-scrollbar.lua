return {
  'petertriho/nvim-scrollbar',
  config = function()
    require('scrollbar').setup {
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = false,
        handle = true,
        search = true, --
      }
    }
  end,
}
