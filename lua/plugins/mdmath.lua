return
{
  'Thiago4532/mdmath.nvim',
  ft = { 'markdown', "python" },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('mdmath').setup({
      server_path = 'node',
      server_args = { os.getenv('HOME') .. '/.local/share/nvim/lazy/mdmath.nvim/mdmath-js/src/server.js' },
      foreground = '#5a966b',
      anticonceal = true,

      conceal_cursor = '',

      dynamic = true,
      dynamic_scale = 0.8,  -- Disable dynamic scaling
      internal_scale = 1.5, -- Double resolution for crisper text
      css = [[
          .math-render {
            min-width: 100% !important;
            margin: 4px 0 !important;
            padding: 8px !important;
            background-color: rgba(200,200,200,0.1);
            border-radius: 4px;
            overflow-x: auto !important;
            white-space: pre !important;  -- Changed from nowrap to pre
          }
          .math-render .katex-display {
            margin: 0.5em 0 !important;
            text-align: left !important;
          }
          .math-render .katex {
            font-size: 1.1em !important;
          }
        ]],
      -- css = [[
      --   .math-render {
      --     min-width: 100% !important;
      --     margin: 4px 0 !important;
      --     padding: 8px !important;
      --     background-color: rgba(200,200,200,0.1);
      --     border-radius: 4px;
      --     overflow-x: auto !important;  -- Add horizontal scroll if needed
      --     white-space: nowrap !important;  -- Prevent wrapping of equations
      --   }
      --   .math-render .katex {
      --     color: #a1a784
      --     display: inline-block !important;  -- Keep equations on one line
      --     white-space: nowrap !important;
      --   }
      -- ]],
      -- Add tex2jax configuration for better math parsing
      -- tex2jax = {
      --   inlineMath = [['$','$'], ['\\(','\\)']],
      --   displayMath = [['$$','$$'], ['\\[','\\]']],
      --   processEscapes = true,
      --   ignoreClass = '.*',
      --   processClass = 'math-render|math|mjx|katex'
      -- }
      tex2jax = {
  inlineMath = [['$','$'], ['\\(','\\)']],
  displayMath = [['$$','$$'], ['\\[','\\]'], ['\\begin{equation*}','\\end{equation*}'], ['\\begin{align*}','\\end{align*}']],
  processEscapes = true,
  ignoreClass = '.*',
  processClass = 'math|math-render|katex|mjx'
}
    })

    -- Add autocommand to prevent wrapping in markdown files
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'markdown', 'tex' },
      callback = function()
        vim.opt_local.wrap = false
        vim.opt_local.linebreak = false
      end
    })
  end,
  init = function()
    vim.fn.jobstart({
      'node',
      vim.fn.expand('~/.local/share/nvim/lazy/mdmath.nvim/mdmath-js/src/server.js')
    }, {
      detach = true,
      on_exit = function() end
    })
  end
}
