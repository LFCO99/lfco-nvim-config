return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		local dap = require("dap")
		require("dap-python").setup(vim.g.python3_host_prog or "python") -- Uses debugpy installed

		-- Django specific configuration
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Django",
				program = "${workspaceFolder}/manage.py",
				args = { "runserver", "--noreload" },
				django = true,
				console = "integratedTerminal",
				justMyCode = false, -- Debug into Django Framework if needed
				pythonPath = vim.g.python3_host_prog or "python3",
			},
		}

		-- Debugging keymaps
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
	end,
}
