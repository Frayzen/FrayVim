return {
  -- Markdown Preview with Port Configuration
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    ft = { "markdown" },
    init = function()
      -- General plugin settings
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = 0  -- Allow multiple previews
      vim.g.mkdp_theme = 'dark'
      -- vim.g.mkdp_refresh_slow = 1 -- Better performance

      -- Port-specific preview commands
      vim.api.nvim_create_user_command('MarkdownPreview8001', function()
        vim.g.mkdp_port = '8001'
        vim.cmd('MarkdownPreview')
      end, { desc = 'Open preview on port 8001' })

      vim.api.nvim_create_user_command('MarkdownPreview8002', function()
        vim.g.mkdp_port = '8002'
        vim.cmd('MarkdownPreview')
      end, { desc = 'Open preview on port 8002' })

      -- Key mappings
      vim.keymap.set('n', '<leader>m1', '<cmd>MarkdownPreview8001<CR>', {
        silent = true,
        desc = 'Markdown Preview (Port 8001)'
      })

      vim.keymap.set('n', '<leader>m2', '<cmd>MarkdownPreview8002<CR>', {
        silent = true,
        desc = 'Markdown Preview (Port 8002)'
      })

      -- Optional: Keep original toggle mapping
      vim.keymap.set('n', '<leader>mt', '<cmd>MarkdownPreviewToggle<CR>', {
        silent = true,
        desc = 'Toggle Markdown Preview'
      })
    end
  },

  -- Basic Markdown Support
  -- {
  --   'preservim/vim-markdown',
  --   ft = 'markdown',
  --   config = function()
  --     vim.g.vim_markdown_math = 1
  --     vim.g.vim_markdown_conceal = 1
  --     vim.g.vim_markdown_folding_disabled = 1
  --   end
  -- },
  -- Enhanced Markdown Features
  {
    "n-crespo/nvim-markdown",
    lazy = true,
    ft = "markdown",
    init = function()
      vim.api.nvim_create_autocmd({ "FileType", "BufReadPost" }, {
        pattern = { "*.md" },
        callback = function()
          vim.cmd("setlocal syn=tex")
        end
      })
    end,
    config = function()
      vim.g.vim_markdown_toc_autofit = 1
      vim.g.vim_markdown_math = 1
      vim.keymap.set("n", "<leader>m", "<cmd>setlocal syn=markdown<CR>", {
        silent = false,
        desc = "Conceal Math",
        buffer = true
      })
    end
  }
}
