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
		["<esc><esc>"] = { "<cmd>noh<CR>", "Remove highlitghting" },
		["<Leader>f"] = {
			name = "Find",
		},
		["<Leader>j"] = {
			name = "Java",
		},
		["<Leader>L"] = { "<cmd>Lazy<CR>", "Lazy" },
	},
	v = {
		["R"] = { select_visual, "Replace all" },
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
