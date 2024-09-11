return {
    "dmmulroy/tsc.nvim",
    config = function()
        require("tsc").setup({
            auto_open_qflist = true,
            auto_close_qflist = false,
            auto_focus_qflist = false,
            auto_start_watch_mode = false,
            use_trouble_qflist = false,
            use_diagnostics = true,
            run_as_monorepo = false,
            enable_progress_notifications = true,
            flags = {
                noEmit = true,
                watch = false,
            },
            hide_progress_notifications_from_history = true,
            spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
            pretty_errors = true,
        })
    end,
}
