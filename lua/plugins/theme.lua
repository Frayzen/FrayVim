-- return {
-- 	"navarasu/onedark.nvim",
-- 	config = function()
-- 		-- Lua
-- 		require("onedark").setup({
-- 			style = "warmer",
-- 		})
-- 		require("onedark").load()
-- 	end,
-- }
-- return {
--     "alexanderbluhm/black.nvim",
--     config = function()
--         -- require("kanagawa").load("wave")
--     end,
-- }
return {
  "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000,
  config = function()
    vim.cmd [[colorscheme moonfly]]
  end,
}
-- return {
--     "rebelot/kanagawa.nvim",
--     config = function()
--         require("kanagawa").load("wave")
--     end,
-- }
