
return {
  -- Markdown Preview with Port Configuration
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",

    -- build = function() vim.fn["mkdp#util#install"]() end,
    ft = { "markdown" },
    init = function()
      -- General plugin settings
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = 0  -- Allow multiple previews
      vim.g.mkdp_theme = 'dark'
      vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/nvim/markdown-preview.css")

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

      -- Original toggle mapping
      vim.keymap.set('n', '<leader>mt', '<cmd>MarkdownPreviewToggle<CR>', {
        silent = true,
        desc = 'Toggle Markdown Preview'
      })
    end
  }
}
