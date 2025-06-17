return {
	"CRAG666/code_runner.nvim",
	config = function()
		require("code_runner").setup({
			filetype = {
				python = "python3 -u",
			},
		})

		vim.keymap.set("n", "<leader>r", ":RunCode<CR>")
	end,
}
