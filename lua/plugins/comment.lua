return {
    "tpope/vim-commentary",
    lazy = false,
    config = function()
        -- vim.cmd("autocmd FileType apache setlocal commentstring=
        register_mapping({
            n = {
                { "<Leader>/", "<Plug>CommentaryLine", desc = "Toggle comment" },
            },
            v = {
                { "<Leader>/", "<Plug>Commentary", desc = "Toggle comment" },
            },
        })
    end,
}
