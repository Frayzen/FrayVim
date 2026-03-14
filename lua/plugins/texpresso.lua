return {
"let-def/texpresso.vim",
config = function()
local texpresso = require("texpresso")

-- Parse TeXpresso log buffer and populate quickfix
local function parse_texpresso_log()
  local buf = vim.fn.bufnr("texpresso-log")
  if buf == -1 then
    print("TeXpresso log buffer not found")
    return
  end

  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local qf = {}
  local seen = {} -- track duplicates
  for i, line in ipairs(lines) do
  if line:match("Undefined control sequence") or line:match("^!") then
    local key = line

    if not seen[key] then
      seen[key] = true

      -- extract filename + line number
      local filename, lnum = line:match("([%w%._/-]+%.tex):(%d+):")

      table.insert(qf, {
        filename = filename or vim.fn.expand("%:p"),
        lnum = tonumber(lnum) or 1,
        text = line,
        type = "E",
      })
    end
  end
end
  if #qf > 0 then
    vim.fn.setqflist({}, "r", { title = "TeXpresso", items = qf })
    vim.cmd("copen")
    print("TeXpresso: found " .. #qf .. " unique errors")
  else
    print("TeXpresso: no errors detected")
  end
end

-- Launch TeXpresso
vim.keymap.set("n", "<leader>tl", function()
  texpresso.launch({ vim.fn.expand("%") })
  -- give TeXpresso time to produce log output
  vim.defer_fn(parse_texpresso_log, 1200)
end, { desc = "Launch TeXpresso" })

-- manually parse errors again
vim.keymap.set("n", "<leader>te", parse_texpresso_log, { desc = "Parse TeXpresso errors" })

-- quickfix navigation
vim.keymap.set("n", "<leader>tn", ":cnext<CR>", { desc = "Next error" })
vim.keymap.set("n", "<leader>tp", ":cprev<CR>", { desc = "Previous error" })
vim.keymap.set("n", "<leader>tq", ":cclose<CR>", { desc = "Close quickfix" })

end,
}

