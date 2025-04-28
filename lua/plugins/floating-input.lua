-- return {
--   'stevearc/dressing.nvim',
--   event = 'VeryLazy',
--   config = function()
--     require("dressing").setup({
--       input = {
--         enabled = true,
--         border = "rounded",
--         prefer_width = 40,
--         title_pos = "center",
--         insert_only = true,
--         relative = "editor",
--       }
--     })

--     -- Override input to insert `$input$` after confirm
--     vim.ui.input = function(opts, on_confirm)
--       require("dressing.input")(opts, function(input)
--         if input and input ~= "" then
--           local row, col = unpack(vim.api.nvim_win_get_cursor(0))
--           local line = vim.api.nvim_get_current_line()
--           local before = line:sub(1, col)
--           local after = line:sub(col + 1)
--           local to_insert = "$" .. input .. "$"
--           vim.api.nvim_set_current_line(before .. to_insert .. after)
--           vim.api.nvim_win_set_cursor(0, { row, col + #to_insert })
--         end

--         if on_confirm then
--           on_confirm(input)
--         end
--       end)
--     end

--     -- Add keymap to edit existing $$ math block using floating input
--     vim.keymap.set("n", "<leader>E", function()
--       local row, col = unpack(vim.api.nvim_win_get_cursor(0))
--       local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

--       -- Find opening $$
--       local start_line = nil
--       for i = row - 1, 0, -1 do
--         if lines[i + 1]:match("^%s*%$%$%s*$") then
--           start_line = i + 1
--           break
--         end
--       end

--       -- Find closing $$
--       local end_line = nil
--       for i = row, #lines - 1 do
--         if lines[i + 1]:match("^%s*%$%$%s*$") then
--           end_line = i + 1
--           break
--         end
--       end

--       if not start_line or not end_line or start_line >= end_line then
--         vim.notify("Not inside a $$ math block", vim.log.levels.WARN)
--         return
--       end

--       local math_lines = vim.api.nvim_buf_get_lines(0, start_line, end_line - 1, false)
--       local math_expr = table.concat(math_lines, "\n")

--       vim.ui.input({ prompt = "Edit math:", default = math_expr }, function(input)
--         if input then
--           local new_lines = vim.split(input, "\n", { plain = true })
--           vim.api.nvim_buf_set_lines(0, start_line, end_line - 1, false, new_lines)
--         end
--       end)
--     end, { desc = "Edit $$ math block" })
--   end
-- }
return {
  'liangxianzhe/floating-input.nvim',
  config = function()
    -- No additional configuration needed
  end
}

