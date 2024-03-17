return {
    "Shatur/neovim-session-manager",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    lazy = false, -- make sure the plugin is always loaded at startup
    config = function()
        local config = require("session_manager.config")
        local session_manager = require("session_manager")
        session_manager.setup({
            autoload_mode = config.AutoloadMode.CurrentDir,
        })
        register_mapping({
            n = {
                ["<Leader>s"] = {
                    s = { "<cmd>SessionManager save_current_session<cr>", "Load" },
                    o = { "<cmd>SessionManager load_session<cr>", "Load" },
                    l = { "<cmd>SessionManager load_last_session<cr>", "Load last" },
                    d = { "<cmd>SessionManager delete_session<cr>", "Delete current session" },
                },
            },
        })
        -- Auto save session
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            callback = function()
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    -- Don't save while there's any 'nofile' buffer open.
                    if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "nofile" then
                        return
                    end
                end
                session_manager.save_current_session()
            end,
        })
        vim.api.nvim_create_autocmd({ "User" }, {
            pattern = "SessionSavePre",
            command = "NvimTreeClose",
        })
    end,
}
