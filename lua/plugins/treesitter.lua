return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"lua",
				"python",
				-- "java",
				"javascript",
				"htmldjango",
				"html",
				"css",
				"scss",
				"typescript",
				-- "xml",
				-- "elixir",
				-- "eex",
				-- "heex",
				"vimdoc",
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
