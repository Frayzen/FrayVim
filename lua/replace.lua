local ns = vim.api.nvim_create_namespace("jupyter_icons")

local rules = {
  { pattern = "# %%",                icon = " ",  hl = "pythonIcon"   },
  { pattern = "# %%%% %[markdown%]", icon = " ",  hl = "markdownIcon" },
}

-- define highlight groups (you can pick any colorschemes values)
vim.api.nvim_set_hl(0, "pythonIcon",   { fg = "#f1c40f" }) -- yellowish
vim.api.nvim_set_hl(0, "markdownIcon", { fg = "#519aba" }) -- bluish

local function add_icons()
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  for lnum, line in ipairs(lines) do
    for _, rule in ipairs(rules) do
      local s, e = string.find(line, rule.pattern)
      if s then
        vim.api.nvim_buf_set_extmark(0, ns, lnum-1, s-1, {
          virt_text = { { " " .. rule.icon .. " ", rule.hl } },
          virt_text_pos = "overlay",
          hl_mode = "combine",
        })
      end
    end
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "TextChangedI" }, {
  callback = add_icons,
})

