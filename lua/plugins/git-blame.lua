return {
    "f-person/git-blame.nvim",
    config = function()
        require('gitblame').setup {
            --Note how the `gitblame_` prefix is omitted in `setup`
            enabled = true,
        }
        vim.g.gitblame_message_template = '<summary> • <date> • <author>'
        vim.g.gitblame_date_format = '%r'
        vim.g.gitblame_delay = 10 -- ms
        vim.g.gitblame_virtual_text_column = 80
    end

}
