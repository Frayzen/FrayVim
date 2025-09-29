return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    image = {
      enabled = true,
      integrations = {
        markdown = {
          enabled = true, -- show images inline in Markdown buffers
        },
      },
    },
  },
  config = function(_, opts)
    local snacks = require("snacks")
    snacks.setup(opts)

    -- toggle images in markdown
    vim.keymap.set("n", "<leader>mi", function()
      snacks.image.toggle()
    end, { desc = "Toggle inline images" })
  end,
}

