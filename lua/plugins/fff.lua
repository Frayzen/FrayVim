return
{
  "dmtrKovalenko/fff.nvim",
  build = "cargo build --release",
  -- or if you are using nixos
  -- build = "nix run .#release",
  opts = {
    -- pass here all the options
        no_swap_file = true,  -- prevent E325 swap file warnings

  },
  config = {
    keymaps = {
      close = { '<C-c>' }
    },
  },
  keymaps = {
    move_up = { '<Up>', '<C-p>' },
    move_down = { '<Down>', '<C-n>' },
    close = '<Esc>',
  },
  keys = {
    {
      "<leader>ff",                 -- try it if you didn't it is a banger keybinding for a picker
      function()
        require("fff").find_files() -- or find_in_git_root() if you only want git files
      end,
      desc = "Open file picker",
    },
  },
}
