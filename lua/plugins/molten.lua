return
{
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependecies = {
        "3rd/image.nvim",
    },
    build = ":UpdateRemotePlugins",
    lazy = false,
    init = function()
        -- this is an example, not a default. Please see the readme for more configuration options
        vim.g.molten_output_win_max_height = 30
        vim.g.molten_image_provider = "image.nvim"
        vim.keymap.set("n", "<Leader>mi", ":MoltenInit<CR>",
            { silent = true, desc = "Initialize the plugin" })
        vim.keymap.set("n", "<Leader>mo", ":MoltenEvaluateOperator<CR>",
            { silent = true, desc = "run operator selection" })
        vim.keymap.set("n", "<Leader>ml", ":MoltenEvaluateLine<CR>",
            { silent = true, desc = "evaluate line" })
        vim.keymap.set("n", "<Leader>mr", ":MoltenReevaluateCell<CR>",
            { silent = true, desc = "re-evaluate cell" })
        vim.keymap.set("v", "<Leader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv",
            { silent = true, desc = "evaluate visual selection" })
    end,
}
