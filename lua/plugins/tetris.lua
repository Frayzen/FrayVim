return {
  "alec-gibson/nvim-tetris",
  cmd = "Tetris",
  config = function()
    vim.keymap.set("n", "<leader>gt", ":Tetris<CR>", { desc = "Play Tetris" })
  end,
}

