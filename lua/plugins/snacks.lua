return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {

    bigfile = { enabled = true },

image = {
  enabled = true,
  max_width = 120,
  max_height = 60,
  scale = 1.5,
  formats = { "png", "jpg", "jpeg", "webp" },
  integrations = {
    markdown = { enabled = true },
  },
}
    -- image = {
    --   enabled = true,
    --   formats = {
    --     "png",
    --     "jpg",
    --     "jpeg",
    --     "gif",
    --     "bmp",
    --     "webp",
    --     "tiff",
    --     "heic",
    --     "avif",
    --     "mp4",
    --     "mov",
    --     "avi",
    --     "mkv",
    --     "webm",
    --     "pdf",
    --   },
    --   integrations = {
    --     markdown = {
    --       enabled = true, -- show images inline in Markdown buffers
    --     },
    --   },
    -- },
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
