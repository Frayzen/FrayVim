vim.keymap.set("n", "<C-k>", vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set("n", "qq", "[{", { desc = "Go to start of function" })
vim.keymap.set("n", "zz", "]}", { desc = "Go to end of function" })

vim.keymap.set("v", "c", function()
  local start_line = vim.fn.line("v")      -- start of visual selection (marked by 'v')
  local end_line = tonumber(vim.fn.input("📋 Copy lines to: "))

  if not end_line or end_line < 1 or end_line > vim.fn.line("$") then
    -- vim.notify("Invalid line number", vim.log.levels.ERROR)
    return
  end

  -- Determine the range boundaries
  local from_line = math.min(start_line, end_line)
  local to_line = math.max(start_line, end_line)

  -- Get lines in range
  local lines = vim.api.nvim_buf_get_lines(0, from_line - 1, to_line, false)
  local text = table.concat(lines, "\n")

  -- Copy to system clipboard
  vim.fn.setreg("+", text)
  vim.notify("Copied lines " .. from_line .. " to " .. to_line .. " to clipboard")

  -- Optional: exit visual mode after copying
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'n', true)
end, { desc = "Copy visual selection to line number" })

local ts_utils = require('nvim-treesitter.ts_utils')

local function copy_current_function()
  local node = ts_utils.get_node_at_cursor()
  if not node then
    vim.notify("No syntax node found under cursor", vim.log.levels.WARN)
    return
  end

  -- Traverse up until you find a 'function' node
  while node and node:type() ~= "function" and node:type() ~= "function_definition" and node:type() ~= "method_definition" do
    node = node:parent()
  end

  if not node then
    vim.notify("No function node found", vim.log.levels.WARN)
    return
  end

  local start_row, _, end_row, _ = node:range()

  -- Get lines of the function
  local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, false)
  local text = table.concat(lines, "\n")

  -- Copy to system clipboard (+ register)
  vim.fn.setreg('+', text)
  vim.notify("Copied function lines " .. (start_row + 1) .. " to " .. (end_row + 1) .. " to clipboard")
end

vim.keymap.set('n', '<leader>cf', copy_current_function, { desc = "Copy current function to clipboard" })

-- python format on save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.py" },
  callback = function()
    vim.cmd("Format")
  end,
})
