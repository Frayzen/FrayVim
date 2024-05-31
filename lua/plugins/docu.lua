return {
    "kkoomen/vim-doge",
    config = function()
        vim.g.doge_enable_mappings = false
        -- Generate comment for current line
        vim.keymap.set("n", "<Leader>D", "<Plug>(doge-generate)")

        -- Interactive mode comment todo-jumping
        vim.keymap.set("n", "<TAB>", "<Plug>(doge-comment-jump-forward)")
        vim.keymap.set("n", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
        vim.keymap.set("i", "<TAB>", "<Plug>(doge-comment-jump-forward)")
        vim.keymap.set("i", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
        vim.keymap.set("x", "<TAB>", "<Plug>(doge-comment-jump-forward)")
        vim.keymap.set("x", "<S-TAB>", "<Plug>(doge-comment-jump-backward)")
    end,
}
