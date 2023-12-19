-- WICH-KEY RELATED KEYMAPS

mappings = {
	n = {
		["<esc><esc>"] = { "<cmd>noh<CR>", "Remove highlitghting" },
		["<Leader>f"] = {
			name = "Find",
		},
		["<Leader>L"] = { "<cmd>Lazy<CR>", "Lazy" },
	},
}

function register_mapping(m)
	local wk = require("which-key")
	for k, v in pairs(m) do
		wk.register(v, {
			mode = k,
		})
	end
end

-- WICH-KEY UNRELATED KEYMAPS

function map(mode, shortcut, command)
	if mode == "all" then
		map("n", shortcut, command)
		map("i", shortcut, command)
		map("v", shortcut, command)
		map("t", shortcut, command)
		map("x", shortcut, command)
	else
		vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
	end
end

map("all", "<C-h>", "<C-w>h")
map("all", "<C-j>", "<C-w>j")
map("all", "<C-k>", "<C-w>k")
map("all", "<C-l>", "<C-w>l")
