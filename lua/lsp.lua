lsp_params = {
	clangd = {
		cmd = {
			"clangd",
			"--offset-encoding=utf-16",
		},
		on_attach = function()
			register_mapping({
				n = {
					["<Leader><Tab>"] = { "<cmd>ClangdSwitchSourceHeader<CR>", "Swap source / header" },
				},
			})
			-- vim.api.nvim_create_autocmd("BufWritePre", {
			-- 	callback = function()
			-- 		vim.lsp.buf.format()
			-- 	end,
			-- })
		end,
	},
	luals = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	},
	asm_lsp = {},
}
