-- LSP

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"folke/neodev.nvim",
	},
	config = function()
		require("telescope").load_extension("ui-select")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				register_mapping({
					n = {
						["<Leader>k"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
						["<Leader>F"] = { "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format" },
						["gr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
						["<M-CR>"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
						["<Leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
						["<Leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
						["<Leader>r"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
						-- ["<C-D>"] = { "<cmd>lua vim.lsp.buf.type_definition<CR>", "Type definiton" },
						["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
						["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
						["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
						["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
					},
                    v = {
						["<M-CR>"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
						["<Leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
						["<Leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
                    }
				})
			end,
		})
	end,
}
