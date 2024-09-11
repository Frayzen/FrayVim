-- WICH-KEY RELATED KEYMAPS
function select_visual()
    local input = vim.fn.input("Replace with: ")
    if input ~= "" then
        local selected = vim.fn.getreg(vim.fn.visualmode())
        -- Escape special characters in input for pattern matching
        local escaped_input = input:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
        -- Replace all occurrences of input text with "hello"
        -- Send the keystrokes to exit visual mode
        -- vim.notify(escaped_input .. " AND " .. selected)
        local cmd = "%s/" .. selected .. "/" .. escaped_input .. "/g"
        vim.cmd(cmd)
    else
        print("No input provided.")
    end
end

mappings = {
    n = {
        { "<esc><esc>", "<cmd>noh<CR>",       desc = "Remove highlitghting" },
        { "<Leader>f,", group = "Find" },
        { "<Leader>j,", group = "Java" },
        { "<Leader>x",  group = "Quickfix" },
        { "<Leader>n",  "<cmd>cnext<cr>",     desc = "Next quickfix" },
        { "<Leader>p",  "<cmd>cprevious<cr>", desc = "Previous quickfix" },
        { "<Leader>o",  "<cmd>copen<cr>",     desc = "Open quickfix" },
        { "<Leader>c",  "<cmd>cclose<cr>",    desc = "Close quickfix" },
        { "<Leader>L",  "<cmd>Lazy<CR>",      desc = "Lazy" },
    },
}
function register_mapping(m)
    local wk = require("which-key")
    for k, v in pairs(m) do
        wk.add({
            mode = k,
            v,
        })
    end
end

-- WICH-KEY UNRELATED KEYMAPS

-- function map(mode, shortcut, command)
--     if mode == "all" then
--         map("n", shortcut, command)
--         map("i", shortcut, command)
--         map("v", shortcut, command)
--         map("t", shortcut, command)
--         map("x", shortcut, command)
--     else
--         vim.api.jvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
--     end
-- end

-- map("all", "<C-h>", "<C-w>h")
-- map("all", "<C-j>", "<C-w>j")
-- map("all", "<C-k>", "<C-w>k")
-- map("all", "<C-l>", "<C-w>l")
