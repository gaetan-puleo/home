return {
  'NvChad/nvim-colorizer.lua',
  config = function ()
    require("colorizer").setup({
      user_default_options = {
        css = true,
        css = true,
        RRGGBBAA = true,
        mode = "background",
        tailwind = true,
        sass = { enable = true }
      },
    })
  end
}
