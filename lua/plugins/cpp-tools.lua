return {
	dir = "~/Code/cpp-tools.nvim",
	-- "Frayzen/cpp-tools.nvim",
	config = function()
		require("cpp-tools").setup()
		require("which-key").add({
			{ "<Leader>t", group = "tools" },
			{
				"<Leader>ti",
				function()
					require("cpp-tools").implement()
				end,
				desc = "Implement",
			},
			{
				"<Leader>tc",
				function()
					require("cpp-tools").create()
				end,
				desc = "Create",
			},
			{
				"<Leader>tr",
				function()
					require("cpp-tools").refactor()
				end,
				desc = "Refactor",
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
	},
}
