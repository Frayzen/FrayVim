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



-- vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
--     pattern = {"*.md", "*.tex"},
--     command = "set filetype=tex"
-- })

-- NVIM v0.10.5-dev-22+g0c995c0efb
-- Build type: Debug
-- LuaJIT 2.1.1713484068
-- Run "nvim -V1 -v" for more info
-- ~/.config/nvim tim-java*                                          02:24:46 PM
-- ❯ 
-----------------------------------------------------------
-- Define highlights with FORCED rendering:
vim.api.nvim_set_hl(0, 'RenderMarkdownH1Bg', {
  bg = '#2E3440',
  default = true,
  ctermbg = 'NONE',
  force = true  -- Critical for persistence
})

vim.api.nvim_create_autocmd({"BufEnter", "TextChanged", "TextChangedI"}, {
  pattern = "*.md",
  callback = function()
    vim.schedule(function()
      -- Force full redraw and render
      vim.cmd([[mode]])  -- Fake mode change
      vim.cmd([[redraw]])
    end)
  end
})
