return {
    "mhartington/formatter.nvim",
    config = function()
        local types = "formatter.filetypes."
        require("formatter").setup({
            filetype = {
                python = {
                    require(types .. "python").black,
                    -- require(types .. "python").isort,
                },
            },
        })

        -- Keybinding for formatting
        vim.api.nvim_set_keymap("n", "<leader>f", ":silent! Format<CR>", { noremap = true, silent = true })
    end,
}

