return {
    "nvim-pack/nvim-spectre",
    config = function()
        require("spectre").setup()
        local keymaps = {
            ["<Leader>R"] = {
                name = "Replace with spectre",
                s = { "<cmd>lua require('spectre').toggle()<CR>", "Toggle spectre" },
                w = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Toggle spectre" },
            }
        }
        register_mapping({
            n = keymaps,
            v = keymaps,
        })
    end,
}
