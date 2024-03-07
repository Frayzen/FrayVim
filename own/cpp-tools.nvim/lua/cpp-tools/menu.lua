local M = {}

local popup = require("plenary.popup")

function M.show_menu(opts, cb, name)
    local height = #opts
    local width = 50
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }

    popup.create(opts, {
        title = name,
        highlight = "CppToolsWindow",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = borderchars,
        callback = cb,
    })
    local bufnr = vim.api.nvim_win_get_buf(0)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "q",
        "<cmd>lua require('cpp-tools.menu').close_menu()<CR>",
        { silent = false }
    )
end

function M.close_menu()
    vim.api.nvim_win_close(0, true)
end

return M
