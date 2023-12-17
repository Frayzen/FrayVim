local wk = require("which-key")

local mappings = {
	n = {
		["<esc><esc>"] = {"<cmd>noh<CR>", "Remove highlitghting" },
		["<Leader>f"] = {
			name = "Find",
			f = {"<cmd>Telescope find_files<CR>", "Find files"},
			k = {"<cmd>Telescope keymaps<CR>", "Find keys"},
			r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File"},
			w = {"<cmd>Telescope live_grep<CR>", "Find in files"},
			m = {"<cmd>Telescope man_pages section={'ALL'}", "Man page"},
		},
		["<M-i>"] = { "<cmd>ToggleTerm direction=float<cr>", "ToggleTerm float" },
		["s"] = { "<Plug>(easymotion-s)", "EasyMotion"},
		["<leader>w"] = { "<Plug>(easymotion-bd-w)", "EasyMotion"},
		["<leader>/"] = {
			"<cmd>lua require('Comment.api').toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)<cr>",
			"Toggle comment line",
		},
	},
	v = {
		s = { "<Plug>(easymotion-s)", "EasyMotion"},
		["<leader>/"] = {
			"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
			"Toggle comment for selection",
		},
		["<Leader>w"] = { "<Plug>(easymotion-bd-w)", "EasyMotion"},
	},
	t = {
		["<M-i>"] = { "<cmd>ToggleTerm direction=float<cr>", "ToggleTerm float" },
	}
}
for k,v in pairs(mappings) do	
	wk.register(v, {
		mode = k
	})
end
