return {
  "NvChad/nvim-colorizer.lua",
  opts = {
    user_default_options = {
      RGB      = true; -- #RGB hex codes
      RRGGBB   = true; -- #RRGGBB hex codes
      names    = true; -- "blue", "red", etc.
      RRGGBBAA = true; -- #RRGGBBAA support
      AARRGGBB = true; -- #AARRGGBB support
      css      = true; -- enable all CSS features
      css_fn   = true; -- enable functions like rgb(), hsl()
      tailwind = true; -- if you're using Tailwind
    },
  },
  config = function(_, opts)
    require("colorizer").setup(nil, opts)
  end,
}

