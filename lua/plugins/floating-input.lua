return {}
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
--         if vim.bo.filetype == "NvimTree" then
--           return
--         end
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
--   end
-- }

