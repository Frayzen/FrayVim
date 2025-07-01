-- commit @6c3bda4a
-- Set leader and load common settings
vim.g.mapleader = " "
require("commons")
require("mappings")

-- LAZY.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)




require("lazy").setup("plugins")  -- Loads all plugins from plugins directory

-- SETUP LSP
require("lsp")




if vim.g.vscode then
  vim.o.cmdheight = 1
  return
end


vim.api.nvim_create_user_command("PatchMdmath", function()
  local ok, mdmath = pcall(require, "mdmath")
  if not ok then
    print("mdmath.nvim not found.")
    return
  end

  -- Save the original render function
  local original_render = mdmath.render
  local original_get_lines = vim.api.nvim_buf_get_lines

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


