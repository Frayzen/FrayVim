return {
    "tpope/vim-commentary",
    lazy = false,
    config = function()
        -- vim.cmd("autocmd FileType apache setlocal commentstring=
        register_mapping({
            n = {
                ["<Leader>/"] = { "<Plug>CommentaryLine", "Toggle comment" },
            },
            v = {
                ["<Leader>/"] = { "<Plug>Commentary", "Toggle comment" },
            },
        })
    end,
}
