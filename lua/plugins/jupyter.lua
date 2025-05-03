-- lua/plugins/jupynium.lua
return {
  "kiyoon/jupynium.nvim",
  -- build step: install the Python package into your user site
  build = "pip3 install --user .",
  dependencies = {
    "rcarriga/nvim-notify",   -- optional, for notifications
    "stevearc/dressing.nvim", -- optional, for UI in kernel selection
  },
  config = function()
    require("jupynium").setup({
      -- path or command to your Python 3 host
      python_host         = "python3",
      -- how to launch Jupyter Notebook
      jupyter_command     = "jupyter notebook",
      -- NBClassic (6.x) endpoint
      default_notebook_URL = "localhost:8888/nbclassic",
      -- keep default keybindings (<Space>x, etc.)
      use_default_keybindings = true,
      -- fold textobjects for cells
      textobjects = { use_default_keybindings = true },
    })
  end,
}

