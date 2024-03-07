return {
    dir = "~/.config/nvim/own/cpp-tools.nvim/",
    config = function()
        require("cpp-tools").setup()
        require("which-key").register({
            ["<Leader>t"] = {
                name = "tools",
                i = {
                    function()
                        require("cpp-tools").implement()
                    end,
                    "Implement",
                },
            },
        })
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
    },
}
