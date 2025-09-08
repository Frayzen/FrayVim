return {
  "gruvw/strudel.nvim",
  build = "npm install",
  event = "VeryLazy",
  config = function()
    local strudel = require("strudel")

    strudel.setup({
      ui = {
        maximise_menu_panel = true,
        hide_menu_panel = false,
        hide_top_bar = false,
        hide_code_editor = false,
        hide_error_display = false,
      },
      update_on_save = false,
      sync_cursor = true,
      report_eval_errors = true,
      custom_css_file = nil,
      headless = false,
      browser_data_dir = ".cache/strudel-nvim/",
      browser_exec_path = nil,
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>gl", "<cmd>StrudelLaunch<cr>", { desc = "Launch Strudel UI" })
    vim.keymap.set("n", "<leader>gt", "<cmd>StrudelToggle<cr>", { desc = "Toggle Strudel playback" })
    vim.keymap.set("n", "<leader>gu", "<cmd>StrudelUpdate<cr>", { desc = "Update Strudel session" })
    vim.keymap.set("n", "<leader>gq", "<cmd>StrudelQuit<cr>", { desc = "Quit Strudel session" })

    -- Extra controls
    vim.keymap.set("n", "<leader>gs", "<cmd>StrudelStart<cr>", { desc = "Start Strudel playback" })
    vim.keymap.set("n", "<leader>gp", "<cmd>StrudelStop<cr>",  { desc = "Stop Strudel playback" })
    vim.keymap.set("n", "<leader>gr", "<cmd>StrudelUpdate<cr>",{ desc = "Refresh / Update playback" })
  end
}


