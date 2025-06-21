return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"lua",
				"python",
				"java",
				"javascript",
				"html",
				"css",
				"xml",
				"typescript",
				"elixir",
				"eex",
				"heex",
			},
			modules = {},
			sync_install = false,
			auto_install = true,
			ignore_install = {},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
