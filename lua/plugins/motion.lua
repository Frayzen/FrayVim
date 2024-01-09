return {
	"phaazon/hop.nvim",
	lazy = false,
	init = function()
		vim.cmd("set cmdheight=1")
		register_mapping({
			n = {
				["<Leader>g"] = { name = "Hop motion" },
			},
		})
	end,
	config = function()
		require("hop").setup()
	end,
	keys = {
		{ "<Leader>gw", "<cmd>HopWord<CR>", desc = "Hop World", mode = { "n", "v" } },
		{ "<Leader>gl", "<cmd>HopLine<CR>", desc = "Hop Line", mode = { "v", "n" } },
		{ "<Leader><Space>", "<cmd>HopChar1<CR>", desc = "Hop Char", mode = { "v", "n" } },
		{ "<Leader>ga", "<cmd>HopAnywhere<CR>", desc = "Hop Anywhere", mode = { "v", "n" } },
	},
}
