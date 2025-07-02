return {
  "nvim-pack/nvim-spectre",
  config = function()
    require("spectre").setup()
    local keymaps = {
      {
        { "<Leader>R", group = "Replace with spectre" },
        {
          "<Leader>s",
          "<cmd>lua require('spectre').toggle()<CR>",
          desc = "Toggle spectre",
        },
        {
          "<Leader>w",
          "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
          desc = "Toggle spectre",
        },
      },
    }
    register_mapping({
      n = keymaps,
      v = keymaps,
    })
  end,
}
