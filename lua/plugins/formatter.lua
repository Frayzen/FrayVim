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
                    function()
                        return {
                            exe = "black",
                            args = { "--line-length", "79", "-" },
                            stdin = true,
                        }
                    end,
                    -- You can also enable isort here if desired:
                    -- require("formatter.filetypes.python").isort,
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
