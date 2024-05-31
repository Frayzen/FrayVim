return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        -- add any options here
        presets = {},
        lsp = {
            progress = {
                enabled = false,
            },
            signature = {
                enabled = false,
            },
        },
        messages = {
            enabled = false, -- enables the Noice messages UI
            view_error = nil,
        },
    },
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- "rcarriga/nvim-notify",
    },
}
