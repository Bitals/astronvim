return{
  "willmcpherson2/gnome.nvim",
  lazy = false,
  config = function()
      if ( os.getenv( "XDG_CURRENT_DESKTOP" ) == "GNOME" ) then
          require("gnome").setup {
              -- these are the default options and can be omitted
              on_light = function()
                  vim.api.nvim_set_option("background", "light")
              end,
              on_dark = function()
                  vim.api.nvim_set_option("background", "dark")
              end,
              }
      else vim.api.nvim_set_option("background", "dark")
      end
  end
}
