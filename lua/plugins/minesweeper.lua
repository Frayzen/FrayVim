return {
  "seandewar/nvimesweeper",
  cmd = "Nvimesweeper",
  config = function()
    -- Optional keymap to start a game quickly
    vim.keymap.set("n", "<leader>gm", ":Nvimesweeper<CR>", { desc = "Play Minesweeper" })
  end,
}

