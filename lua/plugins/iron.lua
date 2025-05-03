-- somewhere global
vim.g.iron_repl_split = "horizontal botright 15 split" -- default vertical split

-- function ToggleIronSplit()
--   if vim.g.iron_repl_split == "vertical botright 60 split" then
--     vim.g.iron_repl_split = "horizontal botright 15 split"
--     vim.notify("Iron.nvim: Using Horizontal Split", vim.log.levels.INFO)
--   else
--     vim.g.iron_repl_split = "vertical botright 60 split"
--     vim.notify("Iron.nvim: Using Vertical Split", vim.log.levels.INFO)
--   end

--   -- re-set iron config
--   require("iron.core").setup {
--     config = {
--       scratch_repl = true,
--       repl_open_cmd = vim.g.iron_repl_split,
--     },
--   }
-- end

-- your keymap to toggle


return {
  "Vigemus/iron.nvim",
  event = "VeryLazy",
  config = function()
    local iron = require("iron.core")
    local view = require("iron.view")
    local common = require("iron.fts.common")

    iron.setup {
      config = {

        repl_definition = {
          sh = {
            command = { "zsh" }
          },
          -- python = {
          --   command = {"ipython", "--no-autoindent"},
          --   format = common.bracketed_paste_python,
          --   block_dividers = {"# %%", "#%%"},

          -- },

          python = {
            command = {"/home/tim/.conda/envs/qiskit/bin/ipython", "--no-autoindent"},
            -- command = { "/home/tim/.conda/envs/ship-cudnn/bin/ipython", "--no-autoindent" },
            -- command = { "/home/tim/.conda/envs/ship-cudnn/bin/ipython", "--no-autoindent" },
            format = require("iron.fts.common").bracketed_paste,
            block_dividers = { "# %%", "#%%" },
          },
          lua = {
            command = { "lua" }
          },
          javascript = {
            command = { "node" }
          },
          typescript = {
            command = { "ts-node" }
          },
          r = {
            command = { "R" }
          },
          julia = {
            command = { "julia" }
          },
        },
        -- repl_open_cmd = view.right("40%"), -- ⬅️ this opens REPL on right in a vertical split

        scratch_repl = true,
        repl_open_cmd = vim.g.iron_repl_split,

        highlight = {
          italic = true
        },
        ignore_blank_lines = true,
      },
      keymaps = {
        send_code_block = "<space>sb",
        send_motion = "<space>sc",
        visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_paragraph = "<space>sp",
        send_until_cursor = "<space>su",
        send_mark = "<space>sm",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
        toggle_repl = "<space>rr",
        restart_repl = "<space>rR",
      }
    }

    -- Additional commands
    vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
    vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
    vim.keymap.set('n', '<space>rl', '<cmd>IronRepl<cr>')
    -- vim.keymap.set("n", "<leader>ii", ToggleIronSplit, { desc = "Toggle Iron Split" })
  end
}
