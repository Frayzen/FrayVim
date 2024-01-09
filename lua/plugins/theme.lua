return {
	"navarasu/onedark.nvim",
	config = function()
		-- Lua
		require("onedark").setup({
			style = "warmer",
		})
		require("onedark").load()
	end,
}
