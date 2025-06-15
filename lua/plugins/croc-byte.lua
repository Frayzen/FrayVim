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
      {
        "<Leader>xo",
        function()
          local popup = require("plenary.popup")

          local Win_id

          function ShowMenu(opts)
            local height = 3
            local width = 5
            local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

            Win_id = popup.create(opts, {
              title = "MyProjects",
              highlight = "MyProjectWindow",
              minwidth = width,
              minheight = height,
              padding = { 2, 10, 2, 10 },
              borderchars = borderchars,
            })
            local bufnr = vim.api.nvim_win_get_buf(Win_id)

            function CloseMenu()
              vim.api.nvim_win_close(Win_id, true)
            end

            vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua CloseMenu()<CR>", { silent = false })
          end

          ShowMenu({ "aa", "Test" })
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
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
