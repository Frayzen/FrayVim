return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    'preservim/vim-markdown',
    ft = 'markdown',
    config = function()
      vim.g.vim_markdown_math = 1
      vim.g.vim_markdown_conceal = 1
      vim.g.vim_markdown_folding_disabled = 1
    end
  },
  {
    "n-crespo/nvim-markdown",
    lazy = true,
    ft = "markdown",
    config = function()
      vim.g.vim_markdown_toc_autofit = 1
      vim.g.vim_markdown_math = 1
      vim.keymap.set(
        "n",
        "<leader>m",
        "<cmd>setlocal syn=markdown<cr>",
        { silent = false, desc = "Conceal Math", buffer = true }
      )
    end,
    init = function()
      vim.api.nvim_create_autocmd({ "FileType", "BufReadPost" }, {
        pattern = { "*.md" },
        callback = function()
          vim.cmd([[
            setlocal syn=tex
          ]])
        end,
      })
    end,
  },
}


