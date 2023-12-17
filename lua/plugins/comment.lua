return {
    'numToStr/Comment.nvim',
    opts = {
        mappings = {
            basic = true,
            extra = true,
        },
    },
    lazy = false,
    keys = {
        {
            "<leader>/",
            "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
            desc = "Toggle comment for selection"
        },
        {
            "<leader>/",
            "<cmd>lua require('Comment.api').toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)<cr>",
            desc = "Toggle comment line",
        },
    }
}
