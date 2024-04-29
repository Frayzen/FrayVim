return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            filters = {
                custom = { "^.git$" },
                exclude = {
                    "^.*test.*$",
                },
            },
        })
        local api = require("nvim-tree.api")
        register_mapping({
            n = {
                ["<Leader>e"] = { "<cmd>NvimTreeToggle<cr>", "Toggle nvim tree" },
                ["?"] = {
                    function()
                        api.tree.toggle_help()
                    end,
                    "Toggle help for nvim tree",
                },
            },
        })
    end,
}
