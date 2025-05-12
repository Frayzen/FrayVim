-- WICH-KEY RELATED KEYMAPS
function select_visual()
  local input = vim.fn.input("Replace with: ")
  if input ~= "" then
    local selected = vim.fn.getreg(vim.fn.visualmode())
    -- Escape special characters in input for pattern matching
    local escaped_input = input:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
    -- Replace all occurrences of input text with "hello"
    -- Send the keystrokes to exit visual mode
    -- vim.notify(escaped_input .. " AND " .. selected)
    local cmd = "%s/" .. selected .. "/" .. escaped_input .. "/g"
    vim.cmd(cmd)
  else
    print("No input provided.")
  end
end

local function toggle_iron()
  local repl_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].filetype == "iron" then
      repl_buf = buf
      break
    end
  end

  if repl_buf then
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == repl_buf then
        vim.cmd("IronHide")
        return
      end
    end
  end

  vim.cmd("IronFocus")
end

mappings = {
  n = {
    { "<esc><esc>", "<cmd>noh<CR>",       desc = "Remove highlitghting" },
    { "<Leader>f,", group = "Find" },
    { "<Leader>j,", group = "Java" },
    { "<Leader>x",  group = "Quickfix" },
    { "<Leader>n",  "<cmd>cnext<cr>",     desc = "Next quickfix" },
    { "<Leader>p",  "<cmd>cprevious<cr>", desc = "Previous quickfix" },
    { "<Leader>o",  "<cmd>copen<cr>",     desc = "Open quickfix" },
    { "<Leader>ir", toggle_iron,          desc = "Toggle Iron REPL" }, -- ← Add this line
    { "<Leader>c",  "<cmd>cclose<cr>",    desc = "Close quickfix" },
    { "<Leader>L",  "<cmd>Lazy<CR>",      desc = "Lazy" },
    -- { "<Leader>F",  "<cmd>Format<CR>",      desc = "Format" },
    -- { "<Leader>it",  "<cmd>require(\"iron.core\").toggle()<CR>",      desc = "Lazy" },
  },
}
function register_mapping(m)
  local wk = require("which-key")
  for k, v in pairs(m) do
    wk.add({
      mode = k,
      v,
    })
  end
end

-- WICH-KEY UNRELATED KEYMAPS

-- function map(mode, shortcut, command)
--     if mode == "all" then
--         map("n", shortcut, command)
--         map("i", shortcut, command)
--         map("v", shortcut, command)
--         map("t", shortcut, command)
--         map("x", shortcut, command)
--     else
--         vim.api.jvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
--     end
-- end

vim.cmd("nnoremap <C-h> <C-w>h")
vim.cmd("nnoremap <C-j> <C-w>j")
vim.cmd("nnoremap <C-k> <C-w>k")
vim.cmd("nnoremap <C-l> <C-w>l")
