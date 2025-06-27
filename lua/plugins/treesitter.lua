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
		-- Just implemented for autopairs
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")

		npairs.setup({
			check_ts = true,
			ts_config = {
				lua = { "string" },
				javascript = { "template_string" },
			},
		})

		local ts_conds = require("nvim-autopairs.ts-conds")

		-- press % => %% only while inside a comment or string
		npairs.add_rules({
			Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
			Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
		})
	end,
}
