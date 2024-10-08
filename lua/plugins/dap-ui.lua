return {
    "rcarriga/nvim-dap-ui",
    lazy = false,
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
        require("dapui").setup()
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            -- dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            -- dapui.close()
        end
        register_mapping({ n = { { "<Leader>d", group = "Debugger" } } })
    end,
    keys = {
        {
            "<Leader>dU",
            function()
                -- require("dapui").open()
                -- require("dapui").close()
                require("dapui").toggle()
            end,
            desc = "Toggle debug UI",
        },
        {
            "<Leader>db",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "Toggle breakpoint",
        },
        {
            "<Leader>dc",
            function()
                require("dap").continue()
            end,
            desc = "Continue",
        },
        {
            "<Leader>di",
            function()
                require("dap").step_into()
            end,
            desc = "Step Into",
        },
        {
            "<Leader>do",
            function()
                require("dap").step_out()
            end,
            desc = "Step Out",
        },
        {
            "<Leader>dr",
            function()
                require("dap").run_last()
            end,
            desc = "Rerun",
        },
        {
            "<Leader>ds",
            function()
                require("dap").step_over()
            end,
            desc = "Step",
        },

        {
            "<Leader>dn",
            function()
                require("dap").step_over()
            end,
            desc = "Next",
        },
    },
}
