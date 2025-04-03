return {
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "mfussenegger/nvim-jdtls", -- Java LSP support
    },
    config = function()
      require("java").setup()
      require("lspconfig").jdtls.setup({})
    end,
  },
}
