-- plugins/render-markdown.lua

return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.nvim', -- Change if using mini.icons or web-devicons instead
  },
  config = function()

    require('render-markdown').setup({
      enabled = true,
      render_modes = { 'n', 'c', 't' },
      max_file_size = 10.0,
      debounce = 100,
      preset = 'none',
      log_level = 'error',
      log_runtime = false,
      file_types = { 'markdown', 'tex' },
      ignore = function() return false end,
      change_events = {},
      injections = {
        gitcommit = {
          enabled = true,
          query = [[
            ((message) @injection.content
              (#set! injection.combined)
              (#set! injection.include-children)
              (#set! injection.language "markdown"))
          ]],
        },
      },
      patterns = {
        markdown = {
          disable = false,
          directives = {
            { id = 17, name = 'conceal_lines', priority = 1000, opts = { extend = true } },
            { id = 18, name = 'conceal_lines' },
          },
        },
      },
      anti_conceal = {
        enabled = false,
        ignore = {
          code_background = true,
          sign = true,
        },
        above = 0,
        below = 0,
      },
      padding = {
        highlight = 'none',
        -- highlight = 'Normal',
      },
      latex = {
        enabled = false,
        render_modes = false,
        converter = 'latex2text',
        highlight = 'RenderMarkdownMath',
        position = 'above',
        top_pad = 0,
        bottom_pad = 0,
      },
      on = {
        attach = function() end,
        initial = function() end,
        render = function() end,
        clear = function() end,
      },
      completions = {
        blink = { enabled = false },
        coq = { enabled = false },
        lsp = { enabled = false },
        filter = {
          callout = function() return true end,
          checkbox = function() return true end,
        },
      },
      heading = {
        enabled = true,
        render_modes = false,
        atx = true,
        setext = false,
        sign = true,
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
        position = 'overlay',
        signs = { '󰫎 ' },
        left_margin = 0,
        left_pad = 0,
        right_pad = 0,
        min_width = vim.o.columns,
        border = false,
        border_virtual = false,
        border_prefix = false,
        backgrounds = {
          'RenderMarkdownH1Bg',
          'RenderMarkdownH2Bg',
          'RenderMarkdownH3Bg',
          'RenderMarkdownH4Bg',
          'RenderMarkdownH5Bg',
          'RenderMarkdownH6Bg',
        },
        foregrounds = {
          'RenderMarkdownH1',
          'RenderMarkdownH2',
          'RenderMarkdownH3',
          'RenderMarkdownH4',
          'RenderMarkdownH5',
          'RenderMarkdownH6',
        },
       

      },
    })
  end,
}
