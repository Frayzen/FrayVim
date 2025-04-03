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
-- return {
--     "rebelot/kanagawa.nvim",
--     config = function()
--         require("kanagawa").load("wave")
--     end,
-- }
