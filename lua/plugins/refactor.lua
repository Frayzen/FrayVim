return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",
		"folke/which-key.nvim",
	},
	config = function()
		require("refactoring").setup({
			prompt_func_return_type = {
				go = false,
				java = false,

				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			prompt_func_param_type = {
				go = false,
				java = false,

				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			printf_statements = {},
			print_var_statements = {},
			show_success_message = false, -- shows a message with information about the refactor on success
			-- i.e. [Refactor] Inlined 3 variable occurrences
		})
		require("telescope").load_extension("refactoring")

		require("which-key").register({
			["<Leader>R"] = {
				function()
					require("telescope").extensions.refactoring.refactors()
				end,
				"Refactor",
			},
		}, { mode = { "n", "v" } })
	end,
}
