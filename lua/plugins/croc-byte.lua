return {
  "Frayzen/croc-byte.nvim",
  -- dir = "~/Code/croc-byte.nvim",
  config = function()
    require("which-key").add({
      mode = "n",
      { "<Leader>x", group = "Share" },
      {
        "<Leader>xs",
        function()
          require("croc-byte").share_yanked()
        end,
        desc = "Share yanked",
      },
      {
        "<Leader>xr",
        function()
          require("croc-byte").receive()
        end,
        desc = "Receive",
      },
    })

    require("which-key").add({
      mode = "v",
      { "<Leader>x", group = "Share" },
      {
        "<Leader>xs",
        function()
          require("croc-byte").share_visual()
        end,
        desc = "Share visual",
      },
    })
  end,
  dependencies = {},
}
