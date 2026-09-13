return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true,
    keys = {
        {"<M-i>", "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float", mode = { "t" , "n"}},
    }
}
