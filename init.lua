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

require("custom")
require("replace")



vim.api.nvim_set_keymap('n', '<leader>fc', ':lua require("qciruit").toggle_circuits()<CR>', { noremap = true, silent = true })
-- Map a key to run it on selected text
vim.api.nvim_set_keymap(
  "v",
  "<leader>qc",
  ":lua require('qciruit').save_circuit_png()<CR>",
  { noremap = true, silent = true }
)
-- diagams
--
--
--
--
--
if vim.g.vscode then
  vim.o.cmdheight = 1
  return
end

vim.cmd([[autocmd BufRead,BufNewFile *.str set filetype=javascript]])


-- vertical split rezising
-- vim.o.equalalways = false
-- vim.keymap.set("n", "<leader>=", "<C-w>=")
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    -- Only apply when exactly 2 vertical splits
    local wins = vim.api.nvim_tabpage_list_wins(0)
    if #wins == 2 then
      vim.cmd("vertical resize 86")
    end
  end
})


-- vim.o.equalalways = true
