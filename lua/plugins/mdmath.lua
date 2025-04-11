return {
  'Thiago4532/mdmath.nvim',
  ft = 'markdown',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    -- Ensure single initialization
    if vim.g.mdmath_configured then return end
    
    -- Clear previous setup attempts
    package.loaded['mdmath'] = nil
    package.loaded['mdmath.config'] = nil
    
    -- Configure with error handling
    local ok, mdmath = pcall(require, 'mdmath')
    if ok then
      mdmath.setup({
        server_path = 'node',
        server_args = { os.getenv('HOME') .. '/.local/share/nvim/lazy/mdmath.nvim/mdmath-js/src/server.js' },
        foreground = 'Normal',
        anticonceal = true,
        dynamic = true
      })
      vim.g.mdmath_configured = true  -- Set guard flag
    else
      vim.notify('mdmath.nvim failed to load', vim.log.levels.ERROR)
    end
    
    -- Single autocommand for server management
    vim.api.nvim_create_autocmd('VimLeave', {
      pattern = '*',
      once = true,
      callback = function()
        if vim.fn.executable('pkill') == 1 then
          vim.fn.system('pkill -f "node.*mdmath"')
        end
      end
    })
  end,
  init = function()
    -- Start server once per Neovim instance
    vim.fn.jobstart({
      'node', 
      vim.fn.expand('~/.local/share/nvim/lazy/mdmath.nvim/mdmath-js/src/server.js')
    }, {
      detach = true,
      on_exit = function() end
    })
  end
}
