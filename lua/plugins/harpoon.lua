return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("harpoon").setup({
      save_on_toggle = true,
    })
    require("telescope").load_extension("harpoon")

    register_mapping({
      n = {
        {
          "<Leader>fh",
          ":Telescope harpoon marks<CR>",
          desc = "Harpoon telescope",
        },
        {
          "<Leader>H",
          function()
            require("harpoon.ui").toggle_quick_menu()
          end,
          desc = "Harpoon marks",
        },
        {
          "<Leader>a",
          function()
            require("harpoon.mark").add_file()
          end,
          desc = "Harpoon add file",
        },
        {
          "<Leader><Leader>a",
          function()
            require("harpoon.ui").nav_file(1)
          end,
          desc = "Harpoon to file 1",
        },
        {
          "<Leader><Leader>s",
          function()
            require("harpoon.ui").nav_file(2)
          end,
          desc = "Harpoon to file 2",
        },
        {
          "<Leader><Leader>d",
          function()
            require("harpoon.ui").nav_file(3)
          end,
          desc = "Harpoon to file 3",
        },
        {
          "<Leader><Leader>f",
          function()
            require("harpoon.ui").nav_file(4)
          end,
          desc = "Harpoon to file 4",
        },
        {
          "<Leader><Leader>g",
          function()
            require("harpoon.ui").nav_file(5)
          end,
          desc = "Harpoon to file 5",
        },
        {
          "<Leader><Leader>h",
          function()
            require("harpoon.ui").nav_file(6)
          end,
          desc = "Harpoon to file 6",
        },
        {
          "<Leader><Leader>j",
          function()
            require("harpoon.ui").nav_file(7)
          end,
          desc = "Harpoon to file 7",
        },
        {
          "<Leader><Leader>k",
          function()
            require("harpoon.ui").nav_file(8)
          end,
          desc = "Harpoon to file 8",
        },
        {
          "<Leader><Leader>l",
          function()
            require("harpoon.ui").nav_file(9)
          end,
          desc = "Harpoon to file 8",
        },
        {
          "<Leader><Leader>;",
          function()
            require("harpoon.ui").nav_file(10)
          end,
          desc = "Harpoon to file 9",
        },
      },
    })
  end,
}
