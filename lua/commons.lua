vim.opt.filetype = "on"
vim.opt.filetype.plugin = "on"
vim.opt.filetype.indent = "on"
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.clipboard = "unnamed"
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.signcolumn = "no"

vim.g.indentLine_char = "┊"
vim.g.indent_blankline_filetype_exclude = "[ dashboard ]"
vim.g.indent_blankline_buftype_exclude = "[ dashboard ]"
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.c", "*.h" },
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(buf, "filetype", "c")
    end,
})
