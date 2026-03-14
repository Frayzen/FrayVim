-- return {
--   "let-def/texpresso.vim",
--   config = function()
--     local texpresso = require("texpresso")

--     local function open_quickfix()
--       if texpresso.fix and #texpresso.fix > 0 then
--         vim.cmd("copen")
--         print("Found " .. #texpresso.fix .. " errors/warnings")
--       end
--     end

--     -- Poll for errors until they appear (up to timeout_ms)
--     local function poll_for_errors(timeout_ms)
--       local start = vim.loop.now()
--       local timer = vim.loop.new_timer()
--       timer:start(0, 200, vim.schedule_wrap(function()
--         if texpresso.fix and #texpresso.fix > 0 then
--           timer:stop()
--           timer:close()
--           open_quickfix()
--         elseif vim.loop.now() - start > timeout_ms then
--           timer:stop()
--           timer:close()
--         end
--       end))
--     end

--     -- Launch TeXpresso with polling
--     vim.keymap.set('n', '<leader>tl', function()
--       texpresso.launch({vim.fn.expand('%')})
--       poll_for_errors(5000) -- poll for 5 seconds
--     end, { desc = "Launch TeXpresso" })

--     -- Manual open
--     vim.keymap.set('n', '<leader>te', open_quickfix, { desc = "Show TeXpresso errors" })
--     vim.keymap.set('n', '<leader>tn', ':cnext<CR>', { desc = "Next error" })
--     vim.keymap.set('n', '<leader>tp', ':cprev<CR>', { desc = "Previous error" })
--     vim.keymap.set('n', '<leader>tq', ':cclose<CR>', { desc = "Close quickfix" })
--   end
-- }

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

  for i, line in ipairs(lines) do
    -- detect common LaTeX errors
    if line:match("Undefined control sequence") then
      table.insert(qf, {
        filename = vim.fn.expand("%"),
        lnum = i,
        text = line,
        type = "E",
      })
    end

    if line:match("^!") then
      table.insert(qf, {
        filename = vim.fn.expand("%"),
        lnum = i,
        text = line,
        type = "E",
      })
    end
  end

  if #qf > 0 then
    vim.fn.setqflist({}, "r", { title = "TeXpresso", items = qf })
    vim.cmd("copen")
    print("TeXpresso: found " .. #qf .. " errors")
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
