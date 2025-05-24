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
  -- {
  -- 'MeanderingProgrammer/render-markdown.nvim',
  -- dependencies = {
  --   'nvim-treesitter/nvim-treesitter',
  --   'echasnovski/mini.nvim' -- or your preferred icon provider
  -- },
  -- opts = {
  --   -- Enable header rendering
  --   rendering = {
  --     headers = true, -- This is crucial
  --     -- Other rendering options
  --   },
  --   -- Optional: Customize header appearance
  --     header_highlight = {
  --       h1 = { fg = "#ff5555", bold = true },
  --       h2 = { fg = "#ff79c6", bold = true },
  --       h3 = { fg = "#bd93f9", italic = true },
  --   },
  --   -- If using LaTeX in headers
  --   latex = {
  --     enabled = false,
  --     -- Additional LaTeX options if needed
  --   }
  -- },
  -- -- Important init code
  -- init = function()
  --   -- Verify treesitter parsers are installed
  --   if not pcall(require, 'nvim-treesitter.parsers') then
  --     vim.notify("Treesitter parsers not available!", vim.log.levels.ERROR)
  --   end

  --   -- Verify plugin loaded correctly
  --   vim.api.nvim_create_autocmd('FileType', {
  --     pattern = 'markdown',
  --     callback = function()
  --       if package.loaded['render-markdown'] then
  --         vim.notify("render-markdown.nvim is active for this buffer", vim.log.levels.INFO)
  --       else
  --         vim.notify("render-markdown.nvim failed to load", vim.log.levels.ERROR)
  --       end
  --     end
  --   })
  -- end
-- }

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
  -- {
  --   "n-crespo/nvim-markdown",
  --   lazy = true,
  --   ft = "markdown",
  --   init = function()
  --     vim.api.nvim_create_autocmd({ "FileType", "BufReadPost" }, {
  --       pattern = { "*.md" },
  --       callback = function()
  --         vim.cmd("setlocal syn=tex")
  --       end
  --     })
  --   end,
  --   config = function()
  --     vim.g.vim_markdown_toc_autofit = 1
  --     vim.g.vim_markdown_math = 1
  --     vim.keymap.set("n", "<leader>m", "<cmd>setlocal syn=markdown<CR>", {
  --       silent = false,
  --       desc = "Conceal Math",
  --       buffer = true
  --     })
  --   end
  -- }
}
