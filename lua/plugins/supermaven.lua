function toggleSupermaven()
    require("supermaven-nvim.api").toggle()
    require("lualine").refresh()
end

return {
    "supermaven-inc/supermaven-nvim",
    lazy = false,
    config = function()
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
        require("supermaven-nvim").setup({
            keymaps = {
                accept_suggestion = "<Tab>",
                clear_suggestion = "<C-]>",
                accept_word = "<C-j>",
            },
            color = {
                suggestion_color = "#555555",
                cterm = 244,
            },
            disable_inline_completion = false, -- disables inline completion for use with cmp
            disable_keymaps = false,  -- disables built in keymaps for more manual control
        })
    end,
}
