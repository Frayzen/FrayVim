return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local dap = require("dap")
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		}
		dap.configurations.c = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				args = function()
					return vim.fn.input("Args:", "")
				end,
				cwd = "${workspaceFolder}",
			},
		}
	end,
}
