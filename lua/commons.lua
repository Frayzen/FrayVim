--keys
vim.opt.filetype = "on"
vim.opt.filetype.plugin = "on"
vim.opt.filetype.indent = "on"
vim.opt.expandtab = true
vim.opt.cmdheight = 0

vim.opt.number = true
vim.opt.autoread = true
vim.opt.clipboard = "unnamed"
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cc = "80"
vim.opt.signcolumn = "yes:1"

vim.g.indentLine_char = "┊"
vim.g.indent_blankline_filetype_exclude = "[ dashboard ]"
vim.g.indent_blankline_buftype_exclude = "[ dashboard ]"
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.c", "*.h" },
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_option(buf, "filetype", "c")
    end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.vert", "*.frag", "*.vs", "*.fs", "*.comp", "*.glsl" },
    callback = function()
        vim.opt.filetype = "glsl"
    end,
})

--Copy Function

local ts_utils = vim.treesitter.ts_utils

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

