-- Create a minimal test file
-- Save as ~/test-llm.lua and run with: nvim -u ~/test-llm.lua

vim.cmd [[set runtimepath=$VIMRUNTIME]]
vim.cmd [[set packpath=/tmp/nvim/site]]

-- Install plugins manually
local lazypath = "/tmp/nvim/site/pack/packer/start/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "Kurama622/llm.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("llm").setup({
        api_type = "ollama",
        url = "http://localhost:11434",
        model = "phi3",
        fetch_key = function() return nil end,
      })
    end,
  },
})

vim.keymap.set("n", "<leader>ac", "<cmd>LLMSessionToggle<cr>")
