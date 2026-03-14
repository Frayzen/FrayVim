
return {
  'Thiago4532/mdmath.nvim',
  lazy = false,
  ft = { 'markdown', 'tex', 'latex' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('mdmath').setup({
      math_patterns = {
        -- Standard $$ blocks
        { start = "\\$\\$", stop = "\\$\\$", priority = 1 },
        -- Single $ math
        { start = "%$", stop = "%$", priority = 2 },
        -- Equation environment - simplified pattern
        { start = "\\begin{equation}", stop = "\\end{equation}", priority = 1 },
        -- Optional: other equation environments
        { start = "\\begin{equation%*}", stop = "\\end{equation%*}", priority = 1 },
        { start = "\\begin{align}", stop = "\\end{align}", priority = 1 },
        { start = "\\begin{align%*}", stop = "\\end{align%*}", priority = 1 },
        -- Indented $$ blocks (4+ spaces)
        { start = "^%s*\\$\\$", stop = "\\$\\$", priority = 2 },
        { start = "^#\\$\\$", stop = "^#\\$\\$", priority = 1 },
      },
      server_path = 'node',
      server_args = { os.getenv('HOME') .. '/.local/share/nvim/lazy/mdmath.nvim/mdmath-js/src/server.js' },
      foreground = '#5a966b',
      anticonceal = true,
      conceal_cursor = '',
      dynamic = true,
      dynamic_scale = 0.8,
      internal_scale = 1.5,
      css = [[
          .math-render {
            min-width: 100% !important;
            margin: 4px 0 !important;
            padding: 8px !important;
            background-color: rgba(200,200,200,0.1);
            border-radius: 4px;
            overflow-x: auto !important;
            white-space: pre !important;
          }
          .math-render .katex-display {
            margin: 0.5em 0 !important;
            text-align: left !important;
          }
          .math-render .katex {
            font-size: 1.1em !important;
          }
        ]],
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
  end,
}
