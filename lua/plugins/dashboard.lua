return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      theme = "hyper",  --  theme is doom and hyper default is hyper
      disable_move = true, --  default is false disable move keymap for hyper
      hide = {
        statusline = true, -- hide statusline default is true
        tabline = true, -- hide the tabline
        winbar = true,  -- hide winbar
      },
      config = {
        header = {
          -- "______ _                      _      ",
          -- "| ___ \\ |                    (_)     ",
          -- "| |_/ / |__   ___   ___ _ __  ___  __",
          -- "|  __/| '_ \\ / _ \\ / _ \\ '_ \\| \\ \\/ /",
          -- "| |   | | | | (_) |  __/ | | | |>  < ",
          -- "\\_|   |_| |_|\\___/ \\___|_| |_|_/_/\\_\\",
          -- "",
          " _____                      _           ",
          "|  ___| __ __ _ _   ___   _(_)_ __ ___  ",
          "| |_ | '__/ _` | | | \\ \\ / / | '_ ` _ \\ ",
          "|  _|| | | (_| | |_| |\\ V /| | | | | | |",
          "|_|  |_|  \\__,_|\\__, | \\_/ |_|_| |_| |_|",
          "                |___/                   ",
        },

        shortcut = {
          { desc = "[  Frayzen]", group = "DashboardShortCut" },
        },
        footer = {},
      },
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
