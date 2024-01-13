return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	-- or                              , branch = '0.1.x',
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
		{ "<leader>fc", "<cmd>Telescope grep_string search=<<<<<<CR>", desc = "Find merge conflict" },
		{ "<leader>ft", "<cmd>Telescope grep_string search=TODO<CR>", desc = "Find TODOs" },
		{ "<leader>fa", "<cmd>Telescope find_files hidden=true no_ignore=true<CR>", desc = "Find all" },
		{ "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Find keys" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
		{ "<leader>fw", "<cmd>Telescope live_grep<CR>", desc = "Find in files" },
		{ "<leader>fm", "<cmd>Telescope man_pages section={'ALL'}<CR>", desc = "Man page" },
	},
}
