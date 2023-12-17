-- WICH-KEY RELATED KEYMAPS

local wk = require("which-key")

local mappings = {
    n = {
        ["<esc><esc>"] = {"<cmd>noh<CR>", "Remove highlitghting" },
        ["<Leader>f"] = {
            name = "Find",
        },
    },
}
for k,v in pairs(mappings) do	
    wk.register(v, {
        mode = k
    })
end

-- WICH-KEY UNRELATED KEYMAPS

function map(mode, shortcut, command)
    if mode == 'all' then
        map('n', shortcut, command)
        map('i', shortcut, command)
        map('v', shortcut, command)
        map('t', shortcut, command)
        map('x', shortcut, command)
    else
        vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
    end

end

function nmap(shortcut, command)
    map('n', shortcut, command)
end

function imap(shortcut, command)
    map('i', shortcut, command)
end

map('all', '<C-h>', '<C-w>h')
map('all', '<C-j>', '<C-w>j')
map('all', '<C-k>', '<C-w>k')
map('all', '<C-l>', '<C-w>l')
