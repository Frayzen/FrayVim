-- return {
--     "mhartington/formatter.nvim",
--     config = function()
--         local types = "formatter.filetypes."
--         require("formatter").setup({
--             filetype = {
--                 python = {
--                     require(types .. "python").black,
--                     -- require(types .. "python").isort,
--                 },
--             },
--         })

--         -- Keybinding for formatting
--         vim.api.nvim_set_keymap("n", "<leader>f", ":silent! Format<CR>", { noremap = true, silent = true })
--     end,
-- }

return {
  "mhartington/formatter.nvim",
  config = function()
    require("formatter").setup({
      filetype = {
        python = {
          -- 1️⃣ Run your custom format.py
          function()
            local filepath = vim.fn.expand("%:p")
            local cmd = "python3 ~/scripts/format.py " .. vim.fn.shellescape(filepath)
            vim.fn.system(cmd)
            return nil
          end,

          -- 2️⃣ Run Black
          function()
            return {
              exe = "black",
              args = { "--line-length", "79", "--quiet", "-" },
              stdin = true,
            }
          end,

          -- 3️⃣ Reload file safely *after* formatting
          function()
            vim.defer_fn(function()
              vim.cmd("silent! checktime")
            end, 200)
            return nil
          end,
        },
      },
    })

    -- Keybinding for formatting
    vim.api.nvim_set_keymap(
      "n",
      "<leader>f",
      ":silent! Format<CR>",
      { noremap = true, silent = true }
    )
  end,
}
