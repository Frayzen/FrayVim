-- ~/.config/nvim/lua/plugins/jupytext.lua
-- return {
--   "GCBallesteros/jupytext.nvim",
--   dependencies = {
--     "stevearc/dressing.nvim",
--     "MeanderingProgrammer/render-markdown.nvim"
--   },
--   config = function()
--     require("jupytext").setup({
--       style = "hydrogen",
--       custom_cell_markers = {
--         code = { start = "^# %%", },
--         markdown = { start = "^# %% [markdown%]" },
--       },
--       filetypes = { "python" },
--       mappings = {
--         next_cell = "]c",
--         prev_cell = "[c",
--         execute_cell = "<leader>ce",
--       },
--       post_hook = function()
--         vim.schedule(function()
--           require('render-markdown').attach(0)
--         end)
--       end
--     })
--   end
-- }
return {
  "GCBallesteros/jupytext.nvim",
  dependencies = { "stevearc/dressing.nvim" },
  config = function()
    require("jupytext").setup({
      style = "hydrogen",
      custom_cell_markers = {
        code = {
          start = "^# %%",  -- start marker for code cells
        },
        markdown = {
          start = "^# %% %[markdown%]",  -- start marker for markdown cells
        },
      },
      filetypes = { "python" },  -- Set this to Python filetype for Jupytext
    })  -- Closing parenthesis for the setup function
  end,
}
