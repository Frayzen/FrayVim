return {
    -- dir = "~/Code/cpp-tools.nvim",
    "Frayzen/cpp-tools.nvim",
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
                c = {
                    function()
                        require("cpp-tools").create()
                    end,
                    "Create",
                },
                r = {
                    function()
                        require("cpp-tools").refactor()
                    end,
                    "Refactor",
                },
            },
        })
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
    },
}
