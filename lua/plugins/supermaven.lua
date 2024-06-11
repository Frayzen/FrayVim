function toggleSupermaven()
    require("supermaven-nvim.api").toggle()
    require("lualine").refresh()
end

return {
    "supermaven-inc/supermaven-nvim",
    lazy = false,
    config = function()
        require("supermaven-nvim").setup({})
        register_mapping({
            n = {

                ["<Leader>a"] = {
                    name = "Tools",
                    i = {
                        "<cmd>lua toggleSupermaven()<CR>",
                        "Toggle tool",
                    },
                },
            },
        })
    end,
}
