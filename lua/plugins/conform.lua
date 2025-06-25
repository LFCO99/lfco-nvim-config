return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- Load before saving files
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				python = {
					-- To fix auto-fixable lint errors.
					"ruff_fix",
					-- To run the Ruff formatter.
					"ruff_format",
					-- To organize the imports
					"ruff_organize_imports",
				}, -- sort imports, then format with black.
				lua = { "stylua" }, -- format with stylua
				-- java = { "google-java-format" },
				-- html = { "prettier" },
				-- css = { "prettier" },
				-- javascript = { "prettier" },
				-- elixir = { "mix_format" },
			},
			-- 	mix_format = {
			-- 		command = "mix",
			-- 		args = { "format", "-" },
			-- 		stdin = true,
			-- 	},
			-- },
			format_on_save = {
				timeout_ms = 500, --  max formatting time
				lsp_fallback = true, -- use lsp if formatter fails
			},
		})
	end,
}
