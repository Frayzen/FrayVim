return {
    "ggandor/leap.nvim",
    lazy = false,
    init = function()
        require("leap").create_default_mappings()
    end,
}
