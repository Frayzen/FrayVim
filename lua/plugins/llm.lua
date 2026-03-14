-- ~/.config/nvim/lua/plugins/llm.lua
return
{
  "Kurama622/llm.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
  config = function()
    require("llm").setup({
      api_type = "ollama:latest",
      url = "http://localhost:11434",
      model = "phi3",

    })
  end,
  keys = {
    { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>" },
  },
}
