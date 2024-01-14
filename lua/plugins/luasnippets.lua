return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	config = function()
		register_mapping({
			n = {
				["<Leader>S"] = { "<cmd>lua require('luasnip.loaders').edit_snippet_files() <CR>", "Edit snippets" },
				["<C-a>"] = { "<cmd>lua require('luasnip').change_choice(1)<CR>", "Next choice" },
				["<C-b>"] = { "<cmd>lua require('luasnip').change_choice(-1)<CR>", "Previous choice" },
			},
			i = {
				["<C-a>"] = { "<cmd>lua require('luasnip').change_choice(1)<CR>", "Next choice" },
				["<C-b>"] = { "<cmd>lua require('luasnip').change_choice(-1)<CR>", "Previous choice" },
			},
		})

		require("luasnip.loaders.from_lua").load({ paths = "./snippets" })
	end,
}
