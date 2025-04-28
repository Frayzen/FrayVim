return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "markdown",
        "markdown_inline",  -- Required for math support
        "lua",
        "vim",
        "vimdoc",
        "python"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,

    -- additional_vim_regex_highlighting = {'python.jupyter'},
      },
      incremental_selection = {
        enable = true,
        disable = {"markdown"},
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    })
  end
}

