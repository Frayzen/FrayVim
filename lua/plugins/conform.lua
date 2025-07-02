return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "black" },
				-- -- You can customize some of the format options for the filetype (:help conform.format)
				-- rust = { "rustfmt", lsp_format = "fallback" },
				-- -- Conform will run the first available formatter
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
				c = { "clang-format" },
				cpp = { "clang-format" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})

		register_mapping({
			n = {
				{ "<Leader>F", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", desc = "Format" },
			},
		})
	end,
}
