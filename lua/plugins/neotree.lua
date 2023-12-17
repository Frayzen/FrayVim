return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
        { "<Leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle explorer" },
        { "<Leader>o", "<cmd>Neotree focus<CR>", desc = "Focus explorer" },
    },
    config = function ()
        require('neo-tree').setup({
            close_if_last_window = true,
            filesystem = {
                filtered_items = {
                    hide_dotfiles = true,
                }
            }
        })
    end
}
