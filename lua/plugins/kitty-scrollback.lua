return
{
  'mikesmithgh/kitty-scrollback.nvim',
  enabled = true,
  lazy = true,
  cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
  event = { 'User KittyScrollbackLaunch' },
  -- version = '*', -- latest stable version, may have breaking changes if major version changed
  -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
  config = function()
    require('kitty-scrollback').setup(
      {
        -- global options
        {
          floating_window = {
            enabled = true,    -- open inside floating window
            border = 'single',
            width = 0.9,
            height = 0.7,
          },
          kitty_get_text = {
            extent = 'all',     -- get all scrollback
            ansi = true,
            auto_paste = true,  -- immediately insert into buffer
          },
        },
        -- optional: override builtin configs
        ksb_builtin_last_cmd_output = {
          kitty_get_text = {
            extent = 'screen',
            ansi = true,
            auto_paste = true,
          },
        }
      }
    )
  end,
}
