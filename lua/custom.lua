vim.keymap.set("n", "<C-k>", vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set("n", "qq", "[{", { desc = "Go to start of function" })
vim.keymap.set("n", "zz", "]}", { desc = "Go to end of function" })

vim.keymap.set("v", "c", function()
  local start_line = vim.fn.line("v") -- start of visual selection (marked by 'v')
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


--- Delete functoin

local function delete_current_function()
  local node = ts_utils.get_node_at_cursor()
  if not node then
    vim.notify("No syntax node found under cursor", vim.log.levels.WARN)
    return
  end

  -- Traverse up until you find a function-like node
  while node and node:type() ~= "function"
    and node:type() ~= "function_definition"
    and node:type() ~= "method_definition" do
    node = node:parent()
  end

  if not node then
    vim.notify("No function node found", vim.log.levels.WARN)
    return
  end

  local start_row, _, end_row, _ = node:range()

  -- Delete lines from buffer
  vim.api.nvim_buf_set_lines(0, start_row, end_row + 1, false, {})
  vim.notify("Deleted function lines " .. (start_row + 1) .. " to " .. (end_row + 1))
end

vim.keymap.set('n', '<leader>df', delete_current_function, { desc = "Delete current function" })


-- Collapse tripple quotes in py files

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- Match lines that are only """ or r""" and conceal them
    vim.cmd([[
      syntax match PyMarkdownQuotes /^\s*r\?"""\s*$/ conceal
      setlocal conceallevel=2
    ]])
  end,
})


-- nb sync
-- ~/config/nvim/nb_sync.lua

local function ipynb_to_py(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  if not name:match("%.ipynb$") then return end

  local py_name = name:gsub("%.ipynb$", ".py")
  local script_path = vim.fn.expand("~/scripts/nb_sync.py") -- expand ~ properly
  local format_path = vim.fn.expand("~/scripts/format.py")

  -- run your conversion script
  local cmd = { "python3", script_path, "to-py", name, py_name }
  local result = vim.fn.system(cmd)

  -- check for errors
  if vim.v.shell_error ~= 0 then
    vim.notify("nb_sync.py failed: " .. result, vim.log.levels.ERROR)
    return
  end

  -- run the formatter on the newly generated .py
  local format_cmd = { "python3", format_path, py_name }
  local format_result = vim.fn.system(format_cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("format.py failed: " .. format_result, vim.log.levels.ERROR)
    return
  end

  -- open the converted and formatted .py file
  vim.schedule(function()
    vim.cmd("setlocal noswapfile")

    vim.cmd("edit! " .. py_name)
  end)
end

local function py_to_ipynb(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  if not name:match("%.py$") then return end

  local ipynb_name = name:gsub("%.py$", ".ipynb")
  if vim.fn.filereadable(ipynb_name) == 1 then
    local script_path = vim.fn.expand("~/scripts/nb_sync.py")
    local cmd = { "python3", script_path, "to-ipynb", name, ipynb_name }
    local result = vim.fn.system(cmd)
    if vim.v.shell_error ~= 0 then
      vim.notify("nb_sync.py failed: " .. result, vim.log.levels.ERROR)
    end
  end
end


-- Open .ipynb: convert to .py and switch buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.ipynb",
  callback = function(args) ipynb_to_py(args.buf) end
})

-- Save .py: update the corresponding .ipynb
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  callback = function(args) py_to_ipynb(args.buf) end
})

-- Patch py.nb


vim.api.nvim_create_user_command("PatchMdmath", function()
  local ok, mdmath = pcall(require, "mdmath")
  if not ok then
    print("mdmath.nvim not found.")
    return
  end

  -- Save the original render function
  local original_render = mdmath.render
  local original_get_lines = vim.api.nvim_buf_get_lines()

  mdmath.render = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    -- Get real lines first, modify only for this render
    local lines = original_get_lines(bufnr, 0, -1, false)
    local modified_lines = vim.deepcopy(lines)

    for i, line in ipairs(modified_lines) do
      modified_lines[i] = line:gsub("x", "y")
    end

    -- Patch get_lines to return modified version just during render
    vim.api.nvim_buf_get_lines = function(_, start, stop, strict)
      return vim.list_slice(modified_lines, start + 1, stop)
    end

    -- Call original render using modified lines
    original_render(bufnr)

    -- Restore original get_lines
    vim.api.nvim_buf_get_lines = original_get_lines
  end

  print("✅ mdmath.render patched: x → y (render only)")
end, {})



-- replace with icons
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local ns = vim.api.nvim_create_namespace("python_icons")

    -- detach first if already attached
    if vim.b[bufnr].python_icons_attached then return end
    vim.b[bufnr].python_icons_attached = true

    -- helper: decorate a single line
    local function decorate_line(lnum, line)
      vim.api.nvim_buf_clear_namespace(bufnr, ns, lnum, lnum + 1)
      local patterns = {
        { pattern = "^%s*# %%%% ?%[markdown]", virt_text = " MARKDOWN            " },
        { pattern = "^%s*# %%%%",              virt_text = " CODE" },
      }
      for _, p in ipairs(patterns) do
        local s = line:find(p.pattern)
        if s then
          vim.api.nvim_buf_set_extmark(bufnr, ns, lnum, 0, {
            virt_text = { { p.virt_text, "Comment" } },
            virt_text_pos = "overlay",
            hl_mode = "replace",
          })
          break
        end
      end
    end

    -- attach to buffer updates
    vim.api.nvim_buf_attach(bufnr, false, {
      on_lines = function(_, buf, _, first, last, new_last, _, _)
        -- process changed lines
        for lnum = first, new_last - 1 do
          local line = vim.api.nvim_buf_get_lines(buf, lnum, lnum + 1, false)[1]
          if line then
            decorate_line(lnum, line)
          end
        end
      end,
      on_detach = function()
        vim.b[bufnr].python_icons_attached = false
      end,
    })

    -- initial pass
    for lnum, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
      decorate_line(lnum - 1, line)
    end
  end,
})

-- format md
vim.api.nvim_create_user_command("Fmt", function()
  -- Save current file
  vim.cmd("write")
  -- Run your formatting script on current file
  local filepath = vim.fn.expand("%:p")
  vim.cmd("silent !python3 ~/scripts/format.py " .. filepath)
  -- Reload the file
  vim.cmd("edit")
end, {})
